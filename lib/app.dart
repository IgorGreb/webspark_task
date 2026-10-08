import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/theme.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';
import 'package:webspark_task/shared/widget/app_bloc_listener.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocListener(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeAnimationDuration: Duration.zero,
          routerConfig: router,
          locale: defaultLocale,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          onGenerateTitle: (context) => context.l10n.homeScreenTitle,
          theme: AppTheme.light,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: mediaQuery.textScaler.clamp(
                  minScaleFactor: AppSizes.textScaleMin,
                  maxScaleFactor: AppSizes.textScaleMax,
                ),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
