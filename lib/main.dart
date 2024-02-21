// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/pages/announcement_page.dart';
import 'package:business_chat/pages/chat_page.dart';
import 'package:business_chat/pages/contact_page.dart';
import 'package:business_chat/pages/create_room_page.dart';
import 'package:business_chat/pages/join_room_page.dart';
import 'package:business_chat/pages/landing_page.dart';
import 'package:business_chat/pages/login_page.dart';
import 'package:business_chat/pages/registration_page.dart';
import 'package:business_chat/pages/search_page.dart';
import 'package:business_chat/pages/starting_page.dart';
import 'package:business_chat/pages/verify_email_page.dart';
import 'package:business_chat/providers/announcement_provider.dart';
import 'package:business_chat/providers/contact_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'dart:developer' as devTools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AnnouncementProvider(),
        )
      ],
      child: MaterialApp(
        routes: {
          homePageRoute: (context) => HomePage(),
          chatPageRoute: (context) => const ChatPage(),
          searchPageRoute: (context) => const SearchPage(),
          contactPageRoute: (context) => const ContactPage(),
          announcementPageRoute: (context) => const AnnouncementPage(),
          landingPageRoute: (context) => LandingPage(),
          joinRoomRoute: (context) => JoinRoomPage(),
          createRoomRoute: (context) => CreateRoomPage(),
          loginPageRoute: (context) => LoginPage(),
          registerPageRoute: (context) => RegisterPage(),
          startingPageRoute: (context) => StartingPage(),
          verfifyPageRoute: (context) => VerifyEmailPage(),
        },
        home: StartingPage(),
      ),
    ),
  );
}

List<String> keyList = m.keys.toList();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Staff Directory"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'ANNOUNCEMENTS'),
              Tab(text: 'DEPARTMENTS'),
            ],
          ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, searchPageRoute);
              },
            ),
          ],
        ),
        body: const TabBarView(children: [
          ContactPage(),
          AnnouncementPage(),
          Center(
            child: Text(''),
          ),
        ]),
      ),
    );
  }
}

Map<String, String> m = {
  "Faez": "CEO",
  "Muneeb": "ACP",
  "Jhanzaib": "DC",
  "aez": "CEO",
  "uneeb": "ACP",
  "hanzaib": "DC",
  "Fez": "CEO",
  "Mueeb": "ACP",
  "Jhazaib": "DC"
};

int lettersTyped = 0;

List<String> searchList = [];

TextEditingController searchController = TextEditingController();