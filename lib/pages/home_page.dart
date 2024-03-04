import 'dart:math';

import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/crud/database.dart';
import 'package:business_chat/pages/announcement_page.dart';
import 'package:business_chat/pages/contact_page.dart';
import 'package:business_chat/pop_ups/room_joined_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

List<String> keyList = m.keys.toList();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final BusinessService _businessService;

  @override
  void initState() {
    _businessService = BusinessService();
    //createOrJoin(context);

    super.initState();
  }

  Future<void> createOrJoin(BuildContext context) async {
    print("object");
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      print("hi");
      final args = modalRoute.settings.arguments;
      if (args != null && args is Map) {
        print("hi 2");
        if (args['type'] == 'create') {
          print("hi 3");
          final org = await (_businessService.createOrganisation(
            id: args[idColumn],
            name: args[nameColumn],
            ownerName: args[ownerNameColumn],
            ownerCnic: int.parse(args[ownerCnicColumn]),
            email: args[emailColumn],
          ));
          _businessService.orgId = args[idColumn];
          print("yppp,${_businessService.orgId}");

          final employee = await (_businessService.createEmployee(
              name: args[ownerNameColumn],
              role: 'owner',
              employeeCnic: int.parse(args[ownerCnicColumn]),
              email: args[emailColumn],
              organisationId: args[idColumn]));
          print(employee.toString());
          print(org.toString());
        } else if (args['type'] == 'join' && args[alreadyJoined] == 'No') {
          _businessService.orgId = args[organisationIdColumn];
          print("ynuu,${_businessService.orgId}");
          final employee = await (_businessService.createEmployee(
              name: args[nameColumn],
              role: args[roleColumn],
              employeeCnic: int.parse(args[employeeCnicColumn]),
              email: args[emailColumn],
              organisationId: args[organisationIdColumn]));
          print(employee.toString());
        }
      }
    }
    // return Future.delayed(Duration(microseconds: 1));
  }

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
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        loginPageRoute, (route) => false);
                  },
                  icon: Icon(Icons.abc)),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, searchPageRoute);
                },
              ),
            ],
          ),
          body: FutureBuilder(
            future: createOrJoin(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return const TabBarView(children: [
                    ContactPage(),
                    AnnouncementPage(),
                    Center(
                      child: Text(''),
                    ),
                  ]);
                default:
                  return CircularProgressIndicator();
              }
            },
          )),
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
