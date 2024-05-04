import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/src/core/common/navigation.dart';
import 'package:chat_app/src/core/router/routers.dart';
import 'package:chat_app/src/core/utils/styles/app_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course App',
      // supportedLocales: [
      //   const Locale('id'),
      //   const Locale('en'),
      // ],
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     cardTheme: CardTheme(
      //         elevation: 3,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(mainBorderRadius))),
      //     fontFamily: 'Nunito',
      //     appBarTheme: AppBarTheme(
      //       backgroundColor: mainColor,
      //       centerTitle: true,
      //       elevation: 2,
      //     ),
      //     primarySwatch: primarySwatch,
      //     elevatedButtonTheme: ElevatedButtonThemeData(
      //         style: ElevatedButton.styleFrom(
      //             disabledForegroundColor: Colors.grey[850]?.withOpacity(0.38),
      //             disabledBackgroundColor:
      //                 Colors.grey[850]?.withOpacity(0.12))),
      //     sliderTheme: SliderThemeData(),
      //     scaffoldBackgroundColor: backgroundGrey,
      //     floatingActionButtonTheme:
      //         FloatingActionButtonThemeData(backgroundColor: mainColor),
      //     tabBarTheme: TabBarTheme(
      //         labelPadding: EdgeInsets.symmetric(horizontal: 20),
      //         labelColor: mainColor,
      //         labelStyle:
      //             TextStyle(color: mainColor, fontWeight: FontWeight.w600),
      //         unselectedLabelColor: Colors.black,
      //         unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600)),
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //     iconTheme: IconThemeData(color: Colors.grey)),
      initialRoute: '/',
      routes: AppRouter.getRoutes(),
    );
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(32, 48, 114, .1),
  100: Color.fromRGBO(32, 48, 114, .2),
  200: Color.fromRGBO(32, 48, 114, .3),
  300: Color.fromRGBO(32, 48, 114, .4),
  400: Color.fromRGBO(32, 48, 114, .5),
  500: Color.fromRGBO(32, 48, 114, .6),
  600: Color.fromRGBO(32, 48, 114, .7),
  700: Color.fromRGBO(32, 48, 114, .8),
  800: Color.fromRGBO(32, 48, 114, .9),
  900: Color.fromRGBO(32, 48, 114, 1),
};
