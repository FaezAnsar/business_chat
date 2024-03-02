// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:business_chat/announcement/announcement_pop_up.dart';
import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/crud/database.dart';

import 'package:business_chat/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as devTools show log;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late final BusinessService _businessService;
  List<EmployeeDB> _employees = [];

  @override
  void initState() {
    _businessService = BusinessService();
    //setEmployees();
    super.initState();
  }

  Future<void> setEmployees() async {
    print(_businessService.orgId);
    final temp = (await _businessService.getAllEmployees()).toList();

    _employees = temp;
    print("employees set");
  }

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
        body: FutureBuilder(
            future: setEmployees(),
            builder: (context, snap) {
              switch (snap.connectionState) {
                case ConnectionState.done:
                  return SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        Consumer<ContactProvider>(
                          builder: (context, value, child) {
                            //print(value);
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _employees.length,
                              itemBuilder: (context, index) {
                                return ContactWidget(
                                    employee: _employees[index]);
                              },
                            );
                          },
                        )
                      ],
                    ),
                  );
                default:
                  return CircularProgressIndicator();
              }
            }));
  }
}

// class Employees {
//   final String name;
//   final String role;
//   final String id;
//   Employees({
//     required this.name,
//     required this.role,
//   }) : id = Uuid().v4();
//   bool pressed = false;

//   void press() {
//     pressed = !pressed;
//   }
// }

class ContactWidget extends StatelessWidget {
  final EmployeeDB employee;
  const ContactWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    devTools.log("Contact Widget built");
    return InkWell(
      onTap: () async {
        // context.read<ContactProvider>().press(employee.id);
        // await Navigator.pushNamed(context, chatPageRoute)
        //     .then((_) => context.read<ContactProvider>().press(employee.id));
      },
      child: Container(
        //this is done to change container color to grey when clicked
        // color: employee.pressed ? Colors.grey : Colors.white,
        color: Colors.white,
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
                      employee.name[0],
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
                        employee.name,
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      ),
                      Text(employee.role, style: TextStyle(fontSize: 15)),
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
