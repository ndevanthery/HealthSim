import 'package:flutter/material.dart';
import 'package:healthsim/navbar/navBar.dart';

const maxWidthScreen = 2500.0;

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "About us",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "This application was created by four dedicated students who worked in collaboration with two esteemed educational institutions - the HES-SO Valais Wallis and the Haaga-Helia University of Applied Sciences in Finland, making this project an international effort. We have poured our hearts and souls into developing an innovative, cutting-edge application that aims to help the healthcare industry by providing users with access to the latest advancements in medical algorythms. With a focus on user experience, this application has been designed to be intuitive and user-friendly, with features that are tailored to meet the needs of healthcare providers and patients alike. We are proud to have been a part of this incredible project and are excited to see the impact it will have on the healthcare industry in the years to come.",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
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
