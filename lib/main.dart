// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/pages/announcement_page.dart';
import 'package:business_chat/pages/chat_page.dart';
import 'package:business_chat/pages/contact_page.dart';
import 'package:business_chat/pages/create_room_page.dart';
import 'package:business_chat/pages/home_page.dart';
import 'package:business_chat/pages/join_room_page.dart';
import 'package:business_chat/pages/landing_page.dart';
import 'package:business_chat/pages/login_page.dart';
import 'package:business_chat/pages/registration_page.dart';
import 'package:business_chat/pages/search_page.dart';
import 'package:business_chat/pages/starting_page.dart';
import 'package:business_chat/pages/verify_email_page.dart';

import 'package:business_chat/providers/bloc/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'dart:developer' as devTools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        routes: {
          homePageRoute: (context) => HomePage(),
          chatPageRoute: (context) => const ChatPage(),
          searchPageRoute: (context) => const SearchPage(),
          contactPageRoute: (context) => ContactPage(
                orgId: "",
              ),
          announcementPageRoute: (context) => AnnouncementPage(
                orgId: '',
                employeeId: '',
              ),
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
