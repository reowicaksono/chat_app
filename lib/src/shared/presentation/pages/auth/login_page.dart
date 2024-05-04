part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  ValueNotifier userCredential = ValueNotifier('');
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AppPreferences _appPreferences = AppPreferences();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    try {
      await _auth.signIn(_emailController.text, _passwordController.text);
      _appPreferences.setLoginState(true);
      Navigation.navigateToPageReplacement(Approute.DASHBOARD);
    } catch (e) {
      alertDialogBuilder(context, "Gagal $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormFieldBuilder(
                            obscureText: false,
                            controller: _emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          TextFormFieldBuilder(
                            obscureText: true,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'Password',
                            minLength: 6,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  login(context);
                                });
                              },
                              child: const Text('Sign In'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // _authenticateWithGoogle(context);
                    },
                    icon: Image.asset(
                      "assets/images/google.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const Text("Don't have an account?"),
                  OutlinedButton(
                    onPressed: () {
                      Navigation.navigateToPage(Approute.SIGNUP_ROUTE);
                    },
                    child: const Text("Sign Up"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
