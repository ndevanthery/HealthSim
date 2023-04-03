import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthsim/about.dart';
import 'package:healthsim/authentification/welcome.dart';
import 'package:healthsim/home.dart';
import '../authentification/login.dart';
import '../authentification/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../language_picker_widget.dart';

const maxWidthScreen = 2500.0;

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxWidthScreen) {
          return DesktopNavBar();
        } else if (constraints.maxWidth > 600 &&
            constraints.maxWidth < maxWidthScreen) {
          return DesktopNavBar();
        } else {
          return MobileNavBar();
        }
      },
    );
  }
}

class DesktopNavBar extends StatefulWidget {
  const DesktopNavBar({super.key});

  @override
  _DesktopNavBarState createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends State<DesktopNavBar> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    setState(() {
      isLoggedIn = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: maxWidthScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "HealthSim",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            const SizedBox(
              width: 30,
            ),
            const LanguagePickerWidget(),
            Row(
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: "Montserrat"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ));
                  },
                  child: Text(AppLocalizations.of(context)!.accueil),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: "Montserrat"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ));
                  },
                  child: Text(AppLocalizations.of(context)!.apropos),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: "Montserrat"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ));
                  },
                  child: Text(AppLocalizations.of(context)!.contact),
                ),
                const SizedBox(
                  width: 30,
                ),
                isLoggedIn
                    ? MaterialButton(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          checkAuthStatus();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomePage(),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.logout,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      )
                    : Row(
                        children: [
                          MaterialButton(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.creercompte,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.senregistrer,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileNavBar extends StatefulWidget {
  @override
  _MobileNavBarState createState() => _MobileNavBarState();
}

class _MobileNavBarState extends State<MobileNavBar> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    setState(() {
      isLoggedIn = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                const LanguagePickerWidget(),
                const Text(
                  "HealthSim",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Montserrat"),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomePage(),
                              ));
                        },
                        child: Text(AppLocalizations.of(context)!.accueil),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Montserrat"),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutPage(),
                              ));
                        },
                        child: Text(AppLocalizations.of(context)!.apropos),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Montserrat"),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ));
                        },
                        child: Text(AppLocalizations.of(context)!.contact),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isLoggedIn
                      ? MaterialButton(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            checkAuthStatus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomePage(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.logout,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        )
                      : Row(
                          children: [
                            MaterialButton(
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.creercompte,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.senregistrer,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
