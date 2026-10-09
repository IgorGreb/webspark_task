import 'dart:math';

import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';

/// Presets for emulating a large server response without network.
///
/// Usage (type into the Home URL field):
/// - `mock://small` — 20 tasks, 10x10
/// - `mock://medium` — 100 tasks, 20x20
/// - `mock://large` — 300 tasks, 30x30 (good for watching progress 0→100%)
/// - `mock://stress` — 500 tasks, 25x25 (max allowed by the repo cap)
/// - Custom: `mock://tasks?count=150&size=30&seed=7&fetchMs=800`
abstract class MockTasks {
  static const String scheme = 'mock';

  static bool isMockUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri?.scheme == scheme;
  }

  /// Parses `mock://<preset>` or `mock://tasks?count=&size=&seed=&fetchMs=`.
  /// Returns null when the URL is not a mock URL.
  static MockConfig? parse(String value) {
    final uri = Uri.tryParse(value.trim());
    if (uri?.scheme != scheme) return null;
    final host = uri!.host.toLowerCase();
    final q = uri.queryParameters;
    int count;
    int size;
    switch (host) {
      case 'small':
        count = 20;
        size = 10;
      case 'medium':
        count = 100;
        size = 20;
      case 'large':
        count = 300;
        size = 30;
      case 'stress':
        count = 500;
        size = 25;
      case 'tasks':
      case '':
        count = int.tryParse(q['count'] ?? '') ?? 100;
        size = int.tryParse(q['size'] ?? '') ?? 20;
      default:
        // Unknown host like mock://foo -> treat as medium, still deterministic.
        count = 100;
        size = 20;
    }
    final seed = int.tryParse(q['seed'] ?? '') ?? 7;
    final fetchMs = int.tryParse(q['fetchMs'] ?? '') ?? 800;
    final submitMs = int.tryParse(q['submitMs'] ?? '') ?? 600;
    count = count.clamp(1, 500);
    size = size.clamp(2, 99);
    return MockConfig(
      count: count,
      size: size,
      seed: seed,
      fetchDelay: Duration(milliseconds: fetchMs.clamp(0, 10000)),
      submitDelay: Duration(milliseconds: submitMs.clamp(0, 10000)),
    );
  }

  /// Deterministic generator: same [seed] always yields the same fields,
  /// so progress runs and golden tests are reproducible.
  static List<TaskModel> generate({
    required int count,
    required int size,
    int seed = 7,
  }) {
    final random = Random(seed);
    return List<TaskModel>.generate(count, (i) {
      final field = _buildField(size, random);
      final start = const PointModel(x: 0, y: 0);
      final end = PointModel(x: size - 1, y: size - 1);
      return TaskModel(
        id: 'mock-${i + 1}',
        field: field,
        start: start,
        end: end,
      );
    });
  }

  static List<String> _buildField(int size, Random random) {
    // ~15% walls: dense enough to force go-arounds, sparse enough that
    // almost every task stays solvable (unsolvable ones are simply skipped
    // by ProcessBloc and still count toward progress).
    final rows = List<String>.generate(size, (y) {
      final chars = List<String>.generate(size, (x) {
        if ((x == 0 && y == 0) || (x == size - 1 && y == size - 1)) {
          return '.';
        }
        return random.nextDouble() < 0.15 ? 'X' : '.';
      });
      return chars.join();
    });
    return rows;
  }
}

class MockConfig {
  const MockConfig({
    required this.count,
    required this.size,
    required this.seed,
    required this.fetchDelay,
    required this.submitDelay,
  });

  final int count;
  final int size;
  final int seed;
  final Duration fetchDelay;
  final Duration submitDelay;
}
