import 'package:chat_app/src/core/utils/preferences/app_preferences.dart';

import 'package:chat_app/src/shared/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/core/utils/constants/app_constant.dart'
    as Appconst;
import 'package:chat_app/src/core/utils/constants/app_routes.dart' as Approute;

class AppRouter {
  static AppPreferences _appPreferences = AppPreferences();

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (_) => SplashScreenPage(),
      Approute.WRAPPER: (_) => Wrapper(),
      Approute.LOGIN_ROUTE: (_) => const LoginPage(),
      Approute.SIGNUP_ROUTE: (_) => const SignupPage(),
      Approute.ONBOARDING_ROUTE: (_) => OnboardingScreen(),
      Approute.DASHBOARD: (context) => const DashboardScreen(),
      Approute.CHAT_ROUTE: (context) {
        final receiveID = ModalRoute.of(context)?.settings.arguments as String?;
        return ChatScreen(
          receiveID: receiveID ?? "",
        );
      },
      Approute.VIDEO_CALL: (context) => const VideoCall(),
    };
  }
}
