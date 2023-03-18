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



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Image.asset(
//                     "assets/healthsim_logo.png",
//                     height: constraints.maxHeight / 10 * 2,
//                   ),
//                   SvgPicture.asset(
//                     "assets/welcome_background.svg",
//                     width: double.maxFinite,
//                     height: constraints.maxHeight / 10 * 5,
//                   ),
//                   SizedBox(
//                     height: constraints.maxHeight / 10 * 2,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const RegisterPage(),
//                                 ));
//                           },
//                           style: ElevatedButton.styleFrom(
//                               fixedSize: const Size(1000, 50),
//                               backgroundColor: Colors.grey[800],
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20))),
//                           child: const Text("Get Started"),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const LoginPage(),
//                                   ));
//                             },
//                             child: const Text("I already have an account"))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
