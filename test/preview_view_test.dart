import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webspark_task/components/preview/view/preview_view.dart';
import 'package:webspark_task/components/not_found/view/not_found_view.dart';
import 'package:webspark_task/components/preview/widget/bloc_provider/preview_bloc_provider.dart';
import 'package:webspark_task/components/preview/widget/grid_cell.dart';
import 'package:webspark_task/components/preview/widget/path_grid.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/di/injection.dart';
import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';

/// 3x3 field with one blocked cell and a path along the main diagonal.
const _field = <String>['...', '.X.', '...'];

final _solved = SolvedModel(
  id: 'preview-test',
  field: _field,
  start: const PointModel(x: 0, y: 0),
  end: const PointModel(x: 2, y: 2),
  steps: const <PointModel>[PointModel(x: 0, y: 0), PointModel(x: 2, y: 2)],
);

Future<void> _pump(WidgetTester tester, SolvedModel solved) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        locale: defaultLocale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        home: child,
      ),
      child: PreviewBlocProvider(solved: solved),
    ),
  );
  await tester.pumpAndSettle();
}

/// Mounts the real app routes on a fresh, isolated router so `/preview` is
/// exercised end to end. A local [GoRouter] (instead of the global singleton)
/// keeps each test's navigation `extra` from leaking into the next one.
Future<GoRouter> _pumpRouter(WidgetTester tester) async {
  final router = GoRouter(
    initialLocation: KRoute.home.path,
    errorBuilder: (context, state) => const NotFoundView(),
    routes: appRoutes,
  );
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        locale: defaultLocale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await configureDependencies();
  });

  testWidgets('renders one square cell per field position', (tester) async {
    await _pump(tester, _solved);

    expect(find.byType(GridCell), findsNWidgets(_field.length * _field.length));
  });

  testWidgets('every cell shows its (x,y) coordinates', (tester) async {
    await _pump(tester, _solved);

    expect(find.text('(0,0)'), findsOneWidget);
    expect(find.text('(2,2)'), findsOneWidget);
    expect(find.text('(1,1)'), findsOneWidget);
  });

  testWidgets('cells stay square', (tester) async {
    await _pump(tester, _solved);

    final cells = tester.widgetList<GridCell>(find.byType(GridCell)).toList();
    expect(cells, isNotEmpty);

    for (final cell in cells) {
      final box = tester.renderObject<RenderBox>(find.byWidget(cell)).size;
      expect(box.width, closeTo(box.height, 0.5));
    }
  });

  testWidgets('start, end and blocked cells get their own role', (
    tester,
  ) async {
    await _pump(tester, _solved);

    GridCell cellAt(int x, int y) =>
        tester.widget<GridCell>(find.byKey(ValueKey('cell_${x}_$y')));

    expect(cellAt(0, 0).role, GridCellRole.start);
    expect(cellAt(2, 2).role, GridCellRole.end);
    expect(cellAt(1, 1).role, GridCellRole.locked);
    expect(cellAt(0, 1).role, GridCellRole.empty);
  });

  testWidgets('path label is written under the grid', (tester) async {
    await _pump(tester, _solved);

    expect(find.text('(0,0)->(2,2)'), findsOneWidget);
  });

  testWidgets('empty path falls back to the empty message', (tester) async {
    await _pump(tester, _solved.copyWith(steps: const <PointModel>[]));

    expect(find.text('No results available.'), findsOneWidget);
  });

  testWidgets('layout survives a 1.2 text scale', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.2)),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            locale: defaultLocale,
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: child,
          ),
          child: PreviewBlocProvider(
            solved: _solved.copyWith(
              field: const <String>[
                '.....',
                '.....',
                '.....',
                '.....',
                '.....',
              ],
              start: const PointModel(x: 0, y: 0),
              end: const PointModel(x: 4, y: 4),
              steps: const <PointModel>[PointModel(x: 0, y: 0)],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(GridCell), findsWidgets);
  });

  testWidgets('large field becomes zoomable and panable', (tester) async {
    // 20x20 field: 24 * 20 = 480 far exceeds the ~340px viewport, so the
    // grid overflows and gets wrapped in an InteractiveViewer.
    await _pump(
      tester,
      _solved.copyWith(
        field: List<String>.filled(20, '.' * 20),
        start: const PointModel(x: 0, y: 0),
        end: const PointModel(x: 19, y: 19),
        steps: const <PointModel>[PointModel(x: 0, y: 0)],
      ),
    );

    expect(find.byType(InteractiveViewer), findsOneWidget);
    // All 400 cells still exist, ready to be panned/zoomed into.
    expect(find.byType(GridCell), findsNWidgets(20 * 20));
  });

  testWidgets('30x30 field is painted instead of built cell by cell', (
    tester,
  ) async {
    // Boards above 20x20 switch to GridCellPainter: building 900+ widget
    // subtrees (and as many layers) in one frame was the build jank source.
    await _pump(
      tester,
      _solved.copyWith(
        field: List<String>.filled(30, '.' * 30),
        start: const PointModel(x: 0, y: 0),
        end: const PointModel(x: 29, y: 29),
        steps: const <PointModel>[PointModel(x: 0, y: 0)],
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(GridCell), findsNothing);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter is GridCellPainter,
      ),
      findsOneWidget,
    );
  });

  testWidgets('GridCellPainter records only the visible window of cells', (
    tester,
  ) async {
    await _pump(
      tester,
      _solved.copyWith(
        field: List<String>.filled(30, '.' * 30),
        start: const PointModel(x: 0, y: 0),
        end: const PointModel(x: 29, y: 29),
        steps: const <PointModel>[PointModel(x: 0, y: 0)],
      ),
    );

    final painter =
        tester
                .widget<CustomPaint>(
                  find.byWidgetPredicate(
                    (widget) =>
                        widget is CustomPaint &&
                        widget.painter is GridCellPainter,
                  ),
                )
                .painter!
            as GridCellPainter;

    // The initial window is the viewport at the identity transform: only the
    // top-left slice of the board may be recorded, not all 900 cells.
    final windowed = _RecordingCanvas();
    painter.paint(windowed, const Size(800, 600));
    // Batched: empty + start (in window) + border — the end cell (29,29)
    // lies outside the window and must not be recorded.
    expect(windowed.paths, hasLength(3));

    final fullCanvas = _RecordingCanvas();
    final full = GridCellPainter(
      size: painter.size,
      cellSize: painter.cellSize,
      roleAt: painter.roleAt,
      visible: const Rect.fromLTWH(0, 0, 100000, 100000),
    );
    full.paint(fullCanvas, const Size(800, 600));
    // empty + start + end + border.
    expect(fullCanvas.paths, hasLength(4));

    final windowedRight = windowed.paths.first.getBounds().right;
    final fullRight = fullCanvas.paths.first.getBounds().right;
    expect(windowedRight, lessThan(fullRight));
    // Full window must cover the whole board (gridSide > 1000 here).
    expect(fullRight, greaterThan(1000));

    // A new window is a new paint decision.
    expect(
      painter.shouldRepaint(
        GridCellPainter(
          size: painter.size,
          cellSize: painter.cellSize,
          roleAt: painter.roleAt,
          visible: const Rect.fromLTWH(240, 240, 100, 100),
        ),
      ),
      isTrue,
    );
    expect(painter.shouldRepaint(painter), isFalse);
  });

  testWidgets('preview route renders the model passed as extra', (
    tester,
  ) async {
    final router = await _pumpRouter(tester);

    router.goNamed(KRoute.preview.name, extra: _solved);
    await tester.pumpAndSettle();

    expect(find.byType(PreviewView), findsOneWidget);
    expect(find.text('Preview screen'), findsOneWidget);
    expect(find.byType(GridCell), findsNWidgets(_field.length * _field.length));
    expect(find.text('(0,0)->(2,2)'), findsOneWidget);
  });

  testWidgets('preview route shows empty state when no extra is passed', (
    tester,
  ) async {
    final router = await _pumpRouter(tester);

    router.goNamed(KRoute.preview.name);
    await tester.pumpAndSettle();

    expect(find.byType(PreviewView), findsOneWidget);
    expect(find.byType(GridCell), findsNothing);
    expect(find.text('No task selected.'), findsOneWidget);
  });
}

/// Captures every [Canvas.drawPath] call; anything else is ignored, which is
/// enough to assert which cells [GridCellPainter] chose to record.
class _RecordingCanvas implements Canvas {
  final List<Path> paths = [];

  @override
  void drawPath(Path path, Paint paint) => paths.add(path);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
