import 'package:business_chat/constants/routes.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, joinRoomRoute);
            },
            child: Text("Join Room"),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber)),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, createRoomRoute);
              },
              child: Text("Create Room"),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)))
        ],
      ),
    );
  }
}
