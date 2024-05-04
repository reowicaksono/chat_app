part of 'pages.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AppPreferences _pref = AppPreferences();

  @override
  void initState() {
    // checkUserLogin();
    super.initState();
  }

  // void checkUserLogin() async {
  //   final bool isLoggedIn = await _pref.getLoginState();
  //   final bool isOnBoarding = await _pref.getOnBoardingState();
  //   print("test: $isOnBoarding  test2 : $isLoggedIn");

  //   if (isOnBoarding) {
  //     if (isLoggedIn) {
  //       Navigation.navigateToPageReplacement(Approute.DASHBOARD);
  //     } else {
  //       Navigation.navigateToPageReplacement(Approute.LOGIN_ROUTE);
  //     }
  //   } else {
  //     Navigation.navigateToPageReplacement(Approute.ONBOARDING_ROUTE);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DashboardScreen();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
