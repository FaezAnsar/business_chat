// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer' as devTools show log;

import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/crud/cloud_storage.dart';
import 'package:business_chat/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  String orgId;
  ContactPage({
    super.key,
    required this.orgId,
  });

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late final FirebaseCloudStorage _businessService;
  List<CloudEmployee> _employees = [];
  //late final String orgId;

  @override
  void initState() {
    super.initState();
    _businessService = FirebaseCloudStorage();

    // Future.delayed(Duration.zero, () {
    //   final modalRoute = ModalRoute.of(context);
    //   if (modalRoute != null) {
    //     print("hi");
    //     final args = modalRoute.settings.arguments;
    //     if (args != null && args is Map) {
    //       print("object");
    //       orgId = args[organisationIdField];
    //     }
    //   }
    // });
  }

  Future<void> setEmployees() async {
    // print(_businessService.orgId);
    final temp =
        (await _businessService.getAllEmployees(organisationId: widget.orgId))
            .toList();

    _employees = temp;
    print("employees set");
  }

  @override
  Widget build(BuildContext context) {
    devTools.log("whole rebuilt");
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //AnnouncementPopUp(context);
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
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _employees.length,
                            itemBuilder: (context, index) {
                              print("building");
                              // if (_employees[index].email !=
                              //     FirebaseAuth.instance.currentUser!.email) {
                              return InkWell(
                                onTap: () async {
                                  final userEmail =
                                      FirebaseAuth.instance.currentUser!.email;
                                  final employees =
                                      (await _businessService.getAllEmployees(
                                              organisationId: widget.orgId))
                                          .toList();
                                  final sender = employees.firstWhere(
                                      (employee) =>
                                          employee.email == userEmail);
                                  // context.read<ContactProvider>().press(employee.id);
                                  // await Navigator.pushNamed(
                                  //     context, chatPageRoute,
                                  //     arguments: {
                                  //       'employee': _employees[index],
                                  //     });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                                sender: sender,
                                                receiver: _employees[index],
                                              )));
                                },
                                onLongPress: () async {
                                  await _businessService.deleteEmployee(
                                      orgId: widget.orgId,
                                      employee: _employees[index]);

                                  setState(() {
                                    // _employees.remove(_employees[index]);
                                  });
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              child: Text(
                                                _employees[index].name[0],
                                                style: TextStyle(fontSize: 30),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _employees[index].name,
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.blue),
                                                ),
                                                Text(_employees[index].role,
                                                    style: TextStyle(
                                                        fontSize: 15)),
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
                              // } else {
                              //   return Container();
                            }
                            //},
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

// class ContactWidget extends StatefulWidget {
//   final CloudEmployee employee;
//   final List<CloudEmployee> employees;
//   const ContactWidget(
//       {super.key, required this.employee, required this.employees});

//   @override
//   State<ContactWidget> createState() => _ContactWidgetState();
// }

// class _ContactWidgetState extends State<ContactWidget> {
//   final _businessService = FirebaseCloudStorage();

//   @override
//   Widget build(BuildContext context) {
//     devTools.log("Contact Widget built");
//     return InkWell(
//       onTap: () async {
//         // context.read<ContactProvider>().press(employee.id);
//         await Navigator.pushNamed(context, chatPageRoute);
//       },
//       onLongPress: () async {
//         await _businessService.deleteEmployee(
//             orgId: widget.employee.id, employee: widget.employee);

//         setState(() {
//           widget.employees.remove(widget.employee);
//         });
//       },
//       child: Container(
//         //this is done to change container color to grey when clicked
//         // color: employee.pressed ? Colors.grey : Colors.white,
//         color: Colors.white,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     child: Text(
//                       widget.employee.name[0],
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.employee.name,
//                         style: TextStyle(fontSize: 25, color: Colors.blue),
//                       ),
//                       Text(widget.employee.role,
//                           style: TextStyle(fontSize: 15)),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 2,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
