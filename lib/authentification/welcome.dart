import 'package:flutter/material.dart';
import 'package:healthsim/Navbar/navBar.dart';
import 'package:healthsim/bottomLandingPage.dart';
import 'package:healthsim/landingPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              Color.fromRGBO(4, 66, 108, 1),
              Color.fromRGBO(0, 137, 207, 1)
            ])),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NavBar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      LandingPage(),
                      SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                      BottomColumns(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
