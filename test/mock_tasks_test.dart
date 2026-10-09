import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/core/validators/url_validator.dart';
import 'package:webspark_task/features/mocks/mock_tasks.dart';
import 'package:webspark_task/shared/models/task_model.dart';

void main() {
  group('MockTasks.parse', () {
    test('presets resolve to expected sizes', () {
      expect(MockTasks.parse('mock://small')?.count, 20);
      expect(MockTasks.parse('mock://medium')?.count, 100);
      expect(MockTasks.parse('mock://large')?.count, 300);
      expect(MockTasks.parse('mock://stress')?.count, 500);
    });

    test('custom query params are honored and clamped', () {
      final config = MockTasks.parse(
        'mock://tasks?count=150&size=30&seed=7&fetchMs=800',
      );
      expect(config?.count, 150);
      expect(config?.size, 30);
      expect(config?.seed, 7);
      expect(config?.fetchDelay.inMilliseconds, 800);

      final clamped = MockTasks.parse('mock://tasks?count=9999&size=999');
      expect(clamped?.count, 500);
      expect(clamped?.size, 99);
    });

    test('non-mock urls return null', () {
      expect(MockTasks.parse('https://example.com/'), isNull);
    });
  });

  group('MockTasks.generate', () {
    test('deterministic for the same seed', () {
      final a = MockTasks.generate(count: 10, size: 10, seed: 7);
      final b = MockTasks.generate(count: 10, size: 10, seed: 7);
      expect(
        a.map((t) => t.field).toList().toString(),
        b.map((t) => t.field).toList().toString(),
      );
    });

    test('fields are square with free corners and valid charset', () {
      final tasks = MockTasks.generate(count: 5, size: 12, seed: 3);
      expect(tasks, hasLength(5));
      for (final TaskModel task in tasks) {
        expect(task.field, hasLength(12));
        for (final row in task.field) {
          expect(row.length, 12);
          expect(RegExp(r'^[.X]+$').hasMatch(row), isTrue);
        }
        expect(task.field.first[0], '.');
        expect(task.field.last[11], '.');
      }
    });
  });

  group('UrlValidator mock scheme', () {
    test('mock urls are valid and safe for request', () {
      expect(UrlValidator.isValid('mock://large'), isTrue);
      expect(UrlValidator.isValid('mock://tasks?count=50&size=15'), isTrue);
      expect(UrlValidator.isSafeForRequest('mock://large'), isTrue);
    });

    test('other schemes still rejected', () {
      expect(UrlValidator.isValid('ftp://example.com'), isFalse);
    });
  });
}
