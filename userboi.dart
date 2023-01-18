import 'package:flutter/material.dart';
import 'package:futurebuilder_api_app/models/Users.dart';

class UserBio extends StatelessWidget {
  final User? user;

  const UserBio({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user!.avatar),
          ),
          Text(user!.name),
          const SizedBox(
            height: 50.0,
          ),
          Text(user!.email),
        ],
      )),
    );
  }
}
