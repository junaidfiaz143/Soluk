import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/app_route.dart';
import 'package:app/services/localisation.dart';
import 'package:app/services/scroll_physics.dart';
import 'package:app/services/text_theme.dart';
import 'package:app/utils/color_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatefulWidget {
  static void setLocale(
    BuildContext context,
    Locale newLocale,
  ) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    AppLocalisation.getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(
          title: APP_TITLE,
          theme: ThemeData(
            backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
            fontFamily: FONT_FAMILY,
            primarySwatch: ColorUtils.createMaterialColor(PRIMARY_COLOR),
            primaryColor: PRIMARY_COLOR,
            textTheme: TextThemeData.textTheme,
          ),
          builder: (context, child) {
            child = BotToastInit()(context, child);
            return scrollBehavior(context, child);
          },
          locale: _locale,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          // home: MainScreen(),
          // home: SocialLinks(),
          localizationsDelegates: AppLocalisation.appDeleteGate,
          routes: AppRoute.route,
          // home: LongVideoExerciseScreen(
          //   weekID: '12',
          //   dayID: '',
          //   workoutID: '',
          //   title: 'Long Video Test',
          //   workoutType: "Long Video",
          // ),
          localeListResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (locale != null && locale.isNotEmpty) {
                for (var loc in locale) {
                  if (supportedLocale.languageCode == loc.languageCode &&
                      supportedLocale.countryCode == loc.countryCode) {
                    return supportedLocale;
                  }
                }
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: AppLocalisation.supportedLocale,
          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      },
    );
  }
}
