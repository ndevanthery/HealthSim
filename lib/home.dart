import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOMEPAGE")),
      body: Center(
          child: Text(
        "YOU ARE LOGGED IN",
        style: TextStyle(fontSize: 30),
      )),
    );
  }
}
