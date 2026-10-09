import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/widget/try_again_widget.dart';

Widget _harness({required VoidCallback onPressed}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, _) => MaterialApp(
      // NoSplash avoids loading the ink_sparkle shader in widget tests.
      theme: ThemeData(splashFactory: NoSplash.splashFactory),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      home: Scaffold(
        body: TryAgainWidget(
          failure: SomeFailure.network,
          onPressed: onPressed,
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('TryAgainWidget shows failure text and fires retry', (
    tester,
  ) async {
    var pressed = 0;
    await tester.pumpWidget(_harness(onPressed: () => pressed++));
    await tester.pump();

    expect(find.text(SomeFailure.network.message), findsOneWidget);
    expect(find.byKey(const ValueKey('try_again_button')), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('try_again_button')));
    await tester.pump();
    expect(pressed, 1);
  });
}
