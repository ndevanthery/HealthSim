import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentification/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HOMEPAGE")),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: const Text("RESULT ")),
          Text(Provider.of<UserProvider>(context).user != null
              ? Provider.of<UserProvider>(context).user!.email
              : "guest"),
        ],
      )),
    );
  }
}
