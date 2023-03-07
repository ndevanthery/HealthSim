import 'package:flutter/material.dart';
import 'package:healthsim/home.dart';

import '../database/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passVisible = false;
  bool isHiddenPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
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
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              alignLabelWithHint: true,
                              label: Text("E-Mail"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
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
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 60),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(1000, 50),
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              onPressed: () async {
                                await login(
                                    emailController.text, passController.text);
                              },
                              child: const Text("Log in "))
                        ]))))));
  }

  login(String email, String password) async {
    AuthService myService = AuthService();

    var registerId = await myService.loginWithEmail(
      email,
      password,
    );
    if (registerId != null) {
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}

class Home {}
