// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:business_chat/pages/announcement_page.dart';
import 'package:business_chat/pages/chat_page.dart';
import 'package:business_chat/pages/contact_page.dart';
import 'package:business_chat/providers/announcement_provider.dart';
import 'package:business_chat/providers/contact_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'dart:developer' as devTools show log;

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AnnouncementProvider(),
        )
      ],
      child: MaterialApp(routes: {
        "/Chat": (context) => const ChatPage(),
        "/Search": (context) => const SearchPage(),
        '/Contacts': (context) => const ContactPage(),
        '/Announcement': (context) => const AnnouncementPage()
      }, home: const HomePage())));
}

List<String> keyList = m.keys.toList();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
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
                Navigator.pushNamed(context, "/Search");
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

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    FocusNode searchFocus = FocusNode();

    //searchController.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      lettersTyped = value.length;
                      print(lettersTyped);
                      searchList = keyList.where((element) {
                        if (lettersTyped >= 1 &&
                            element.length >= lettersTyped) {
                          return element
                                  .substring(0, lettersTyped)
                                  .toLowerCase() ==
                              value.substring(0, lettersTyped).toLowerCase();
                        }
                        print(searchList);
                        return false;
                      }).toList();
                    });
                  },
                  controller: searchController,
                  focusNode: searchFocus,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: " Search...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
            child: (lettersTyped >= 1)
                ? ListView.builder(
                    //counting how many matches are there between letters typed and names in database
                    itemCount: searchList.length,
                    itemBuilder: (context, index) {
                      print("NOO");
                      String key = searchList[index];
                      return ContactWidget(
                          contact: Contact(name: key, role: m[key] ?? "N/A"));
                    },
                  )
                : Container())
      ]),
    );
  }
}
