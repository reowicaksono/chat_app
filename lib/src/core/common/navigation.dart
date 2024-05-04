import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, {Object? arguments}) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static intentWithDataPush(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  // static intentWithDataPush(String routeName,
  //     {Map<String, dynamic>? arguments}) {
  //   navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  // }

  static navigateToPageReplacement(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static void navigateToPage(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }
}
