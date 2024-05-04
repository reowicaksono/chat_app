part of '../pages.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaController = TextEditingController();
  final _noHp = TextEditingController();

  final AuthService _auth = AuthService();
  final AppPreferences _appPreferences = AppPreferences();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signUp(_emailController.text, _passwordController.text,
            _namaController.text, _noHp.text);
        _appPreferences.setLoginState(true);
        Navigation.navigateToPageReplacement(Approute.DASHBOARD);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          alertDialogBuilder(context, "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          alertDialogBuilder(
              context, "The account already exists for that email.");
        }
      } catch (e) {
        alertDialogBuilder(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
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
                          controller: _namaController,
                          hintText: 'Name',
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormFieldBuilder(
                          obscureText: false,
                          controller: _noHp,
                          hintText: 'Number',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormFieldBuilder(
                          obscureText: false,
                          controller: _emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldBuilder(
                          obscureText: true,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          minLength: 6,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                signUp(context);
                              });
                            },
                            child: const Text('Sign Up'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Text("Already have an account?"),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("Sign In"),
                ),
                const Text("Or"),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/google.png",
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
