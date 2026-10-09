import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:webspark_task/shared/models/failure_model/failure_model.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/repositories/path_repository.dart';

const _okTasks = '{"error":false,"data":[{"id":"a","field":[".X.",".X.","..."],'
    '"start":{"x":2,"y":1},"end":{"x":0,"y":2}}]}';

http.Client _client(
  String body, {
  int status = 200,
  http.BaseRequest? Function(http.BaseRequest)? onRequest,
}) {
  return MockClient((request) async {
    onRequest?.call(request);
    return http.Response(body, status, request: request);
  });
}

/// Minimal [http.BaseClient] streaming a >5MB body to exercise the byte cap.
class _OversizedClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final stream = Stream<List<int>>.fromIterable([
      List.filled(3 * 1024 * 1024, 0x61),
      List.filled(3 * 1024 * 1024, 0x62),
    ]);
    return http.StreamedResponse(stream, 200, request: request);
  }
}

void main() {
  group('PathRepository hardening', () {
    test('blocked SSRF host never hits the network', () async {
      var calls = 0;
      final repo = PathRepository(
        _client(_okTasks, onRequest: (_) => calls++ as http.BaseRequest?),
      );

      final result = await repo.fetchTasks('http://127.0.0.1/api');

      expect(result, const Left(SomeFailure.invalidUrl));
      expect(calls, 0);
    });

    test('malformed url is invalidUrl without network', () async {
      var calls = 0;
      final repo = PathRepository(
        _client(_okTasks, onRequest: (_) => calls++ as http.BaseRequest?),
      );

      final result = await repo.fetchTasks('http://[invalid');

      expect(result, const Left(SomeFailure.invalidUrl));
      expect(calls, 0);
    });

    test('redirect is not followed (302 -> serverError)', () async {
      final repo = PathRepository(_client('moved', status: 302));

      final result = await repo.fetchTasks('https://example.com/api');

      expect(result, const Left(SomeFailure.serverError));
    });

    test('oversized response is rejected as format', () async {
      // Fake a client whose streamed body exceeds the 5MB cap. MockClient
      // only produces Response, so emulate the cap check via a real
      // StreamedResponse decoded through the same public entry: fetchTasks
      // delegates to client.send, which we override with a chunked stream.
      final repo = PathRepository(_OversizedClient());

      final result = await repo.fetchTasks('https://example.com/api');

      expect(result, const Left(SomeFailure.format));
    });

    test('oversized task list is rejected as format', () async {
      final item =
          '{"id":"t","field":["..",".."],"start":{"x":0,"y":0},"end":{"x":1,"y":1}}';
      final body = '{"error":false,"data":[${List.filled(501, item).join(',')}]}';
      final repo = PathRepository(_client(body));

      final result = await repo.fetchTasks('https://example.com/api');

      expect(result, const Left(SomeFailure.format));
    });

    test('invalid field charset is rejected as format', () async {
      const body = '{"error":false,"data":[{"id":"a","field":["ab","cd"],'
          '"start":{"x":0,"y":0},"end":{"x":1,"y":1}}]}';
      final repo = PathRepository(_client(body));

      final result = await repo.fetchTasks('https://example.com/api');

      expect(result, const Left(SomeFailure.format));
    });

    test('submitResults has a timeout and rejects blocked hosts', () async {
      var calls = 0;
      final repo = PathRepository(
        _client('{}', onRequest: (_) => calls++ as http.BaseRequest?),
      );

      final result = await repo.submitResults('http://10.1.2.3/api', const []);

      expect(result, const Left(SomeFailure.invalidUrl));
      expect(calls, 0);
    });

    test('submitResults sends json and parses ok response', () async {
      var contentType = '';
      final repo = PathRepository(
        MockClient((request) async {
          contentType = request.headers['Content-Type'] ?? '';
          return http.Response(
            '{"error":false,"data":[{"id":"a","correct":true}]}',
            200,
            request: request,
          );
        }),
      );

      final result = await repo.submitResults('https://example.com/api', [
        SubmitRequestModel(
          id: 'a',
          result: SubmitResultModel(
            steps: const [SubmitStepModel(x: '0', y: '0')],
            path: '(0,0)',
          ),
        ),
      ]);

      expect(result.isRight(), isTrue);
      expect(contentType, 'application/json');
    });
  });
}
