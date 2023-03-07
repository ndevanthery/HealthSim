import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
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
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      alignLabelWithHint: true,
                      label: Text("E-Mail"),
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
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
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
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(1000, 50),
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: () {},
                      child: const Text("Create Account ")),
                ]),
              ),
            ),
          ),
        ));
  }
}
