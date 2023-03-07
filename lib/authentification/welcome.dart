import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthsim/authentification/login.dart';
import 'package:healthsim/authentification/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/healthsim_logo.png",
                    height: constraints.maxHeight / 10 * 2,
                  ),
                  SvgPicture.asset(
                    "assets/welcome_background.svg",
                    width: double.maxFinite,
                    height: constraints.maxHeight / 10 * 5,
                  ),
                  SizedBox(
                    height: constraints.maxHeight / 10 * 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(1000, 50),
                              backgroundColor: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text("Get Started"),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                            child: const Text("I already have an account"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
