import 'package:flutter/material.dart';
import 'package:healthsim/authentification/welcome.dart';
import 'package:healthsim/navbar/navBar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../database/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool error = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const NavBar(),
          toolbarHeight:
              screenWidth >= 600 && screenWidth < maxWidthScreen ? 100 : 200,
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(4, 66, 108, 1),
                  Color.fromRGBO(0, 137, 207, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
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
                Image.asset("assets/images/login.png"),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    alignLabelWithHint: true,
                    label: Text(AppLocalizations.of(context)!.email),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                error ? const Color(0xFFFF0000) : const Color(0xFF000000)),
                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                error ? const Color(0xFFFF0000) : const Color(0xFF000000)),
                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                error ? const Color(0xFFFF0000) : const Color(0xFF000000)),
                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passController,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: !passVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    alignLabelWithHint: true,
                    label: Text(AppLocalizations.of(context)!.motdepasse),
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
                          color:
                              error ? const Color(0xFFFF0000) : const Color(0xFF000000)),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                error ? const Color(0xFFFF0000) : const Color(0xFF000000)),
                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                error ? const Color(0xFFFF0000) : const Color(0xFF000000)),
                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  error ? "Wrong username or password ! " : "",
                  style: const TextStyle(fontSize: 18, color: Colors.red),
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
                      bool isError = await login(
                          emailController.text, passController.text);
                      setState(() {
                        loading = false;
                        error = isError;
                      });
                    },
                    child: Text(AppLocalizations.of(context)!.senregistrer)),
                const SizedBox(
                  height: 20,
                ),
                if (loading)
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballClipRotate),
                  )
              ])),
        ))));
  }

  Future<bool> login(String email, String password) async {
    AuthService myService = AuthService();

    var registerId = await myService.loginWithEmail(
      email,
      password,
    );
    if (registerId != null) {
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
      return false;
    }
    return true;
  }
}

class Home {}
