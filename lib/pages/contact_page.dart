// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:business_chat/pop_ups/announcement_pop_up.dart';
import 'package:business_chat/constants/routes.dart';

import 'package:business_chat/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as devTools show log;

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    devTools.log("whole rebuilt");
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AnnouncementPopUp(context);
          },
          child: Icon(Icons.add_alert_sharp),
        ),
        //appBar: AppBar(title: Text("hi")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<ContactProvider>(
                builder: (context, value, child) {
                  //print(value);
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: value.contacts.length,
                    itemBuilder: (context, index) {
                      return ContactWidget(contact: value.contacts[index]);
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}

class Contact {
  final String name;
  final String role;
  final String id;
  Contact({
    required this.name,
    required this.role,
  }) : id = Uuid().v4();
  bool pressed = false;

  void press() {
    pressed = !pressed;
  }
}

class ContactWidget extends StatelessWidget {
  final Contact contact;
  const ContactWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    devTools.log("Contact Widget built");
    return InkWell(
      onTap: () async {
        context.read<ContactProvider>().press(contact.id);
        await Navigator.pushNamed(context, chatPageRoute)
            .then((_) => context.read<ContactProvider>().press(contact.id));
      },
      child: Container(
        //this is done to change container color to grey when clicked
        color: contact.pressed ? Colors.grey : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(
                      contact.name[0],
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      ),
                      Text(contact.role, style: TextStyle(fontSize: 15)),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
