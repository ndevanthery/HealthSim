import 'package:flutter/material.dart';
import 'package:healthsim/Models/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tuple/tuple.dart';

import '../database/auth.dart';
import '../home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfController = TextEditingController();
  bool passVisible = false;
  bool passConfVisible = false;
  bool isHiddenPass = true;
  bool loading = false;

  bool emailError = false;
  bool passwordError = false;
  bool passwordConditionError = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    errorMessage = (emailError
        ? "your email not valid !"
        : (passwordConditionError
            ? '''your password must be at least contain :
            - 8 characters
            - one Uppercase letter
            - one Lowercase letter
            - one special character'''
            : (passwordError ? "your passwords aren't matching ! " : "")));

    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 1000,
                minHeight: 100,
                minWidth: 100,
                maxWidth: 600,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    controller: fullnameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      alignLabelWithHint: true,
                      label: Text("Full name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      alignLabelWithHint: true,
                      label: const Text("E-Mail"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: emailError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: emailError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: emailError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: !passVisible,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      alignLabelWithHint: true,
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passVisible = !passVisible;
                          });
                        },
                        icon: passVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordError || passwordConditionError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordError || passwordConditionError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordError || passwordConditionError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passConfController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: !passConfVisible,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      alignLabelWithHint: true,
                      label: const Text("Confirm Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passConfVisible = !passConfVisible;
                          });
                        },
                        icon: passConfVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordError || passwordConditionError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordError || passwordConditionError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordError || passwordConditionError
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF000000)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(1000, 50),
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        Tuple3 verif = verifications(emailController.text,
                            passController.text, passConfController.text);
                        setState(() {
                          emailError = !verif.item1;
                          passwordError = !verif.item2;
                          passwordConditionError = !verif.item3;
                        });
                        if (verif.item1 & verif.item2 & verif.item3) {
                          bool result = await register(
                              emailController.text,
                              passController.text,
                              UserM(
                                  email: emailController.text,
                                  fullName: fullnameController.text));
                          if (!result) {
                            var snackBar = SnackBar(
                              content: const Text(
                                  'An error occured. Your email is already linked to an account.'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: const Text("Create Account ")),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, height: 1.5),
                  ),
                  if (loading)
                    const SizedBox(
                      height: 100,
                      width: 100,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotate),
                    )
                ]),
              ),
            ),
          ),
        ));
  }

  bool validatePassword(String password) {
    // Define a regular expression pattern to match against the password
    final pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$';

    // Create a RegExp object to use for matching
    final regExp = RegExp(pattern);
/*     print(regExp.hasMatch(password));
 */ // Return true if the password matches the pattern, false otherwise
    return regExp.hasMatch(password);
  }

  verifications(String email, String password, String passwordConf) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return Tuple3(
        emailValid, password == passwordConf, validatePassword(password));
  }

  register(String email, String password, UserM userM) async {
    AuthService myService = AuthService();

    var registerId = await myService.registerWithEmail(email, password, userM);
    if (registerId != null) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return true;
    }
    return false;
  }
}
