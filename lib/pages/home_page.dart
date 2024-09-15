import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/crud/cloud_storage.dart';
import 'package:business_chat/pages/announcement_page.dart';
import 'package:business_chat/pages/contact_page.dart';
import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
import 'package:business_chat/providers/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> keyList = m.keys.toList();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseCloudStorage _businessService;
  late final String orgId;
  late final String employeeId;
  @override
  void initState() {
    super.initState();
    _businessService = FirebaseCloudStorage();
    //initializeOrgId();
    //createOrJoin(context);
  }

  Future<String> initializeOrgId() async {
    await Future.delayed(Duration.zero, () {
      final modalRoute = ModalRoute.of(context);
      if (modalRoute != null) {
        print("hi");
        final args = modalRoute.settings.arguments;
        if (args == null) print("yess");

        if (args != null && args is Map) {
          print("nuio");

          orgId = args[organisationIdField];
          employeeId = args[employeeIdField];
          return orgId;
        }
      }
      return orgId;
    });
    return orgId;
  }

  // Future<void> createOrJoin(BuildContext context) async {
  //   print("object");
  //   final modalRoute = ModalRoute.of(context);
  //   if (modalRoute != null) {
  //     print("hi");
  //     final args = modalRoute.settings.arguments;
  //     if (args != null && args is Map) {
  //       print("hi 2");
  //       if (args['type'] == 'create') {
  //         print("hi 3");
  //         final org = await (_businessService.createOrganisation(
  //           name: args[nameField],
  //           owner_name: args[ownerNameField],
  //           owner_cnic: int.parse(args[ownerCnicField]),
  //           email: args[emailField],
  //         ));
  //         // _businessService.orgId = args[idColumn];
  //         // print("yppp,${_businessService.orgId}");
  //         print("object222");
  //         final employee = await (_businessService.createEmployee(
  //             name: args[ownerNameField],
  //             role: 'owner',
  //             employeeCnic: int.parse(args[ownerCnicField]),
  //             email: args[emailField],
  //             organisationId: org.id));
  //         orgId = org.id;
  //         print("employee.toString()");
  //         print(org.toString());
  //         print("yooo");
  //       } else if (args['type'] == 'join' && args[alreadyJoined] == 'No') {
  //         //  _businessService.orgId = args[organisationIdColumn];
  //         //print("ynuu,${_businessService.orgId}");
  //         final employee = await (_businessService.createEmployee(
  //             name: args[nameField],
  //             role: args[roleField],
  //             employeeCnic: int.parse(args[employeeCnicField]),
  //             email: args[emailField],
  //             organisationId: args[organisationIdField]));
  //         print(employee.toString());
  //       }
  //     }
  //   }
  //   // return Future.delayed(Duration(microseconds: 1));
  // }

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
              IconButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
          body: FutureBuilder(
            future: initializeOrgId(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return TabBarView(children: [
                    ContactPage(
                      orgId: orgId,
                    ),
                    AnnouncementPage(orgId: orgId, employeeId: employeeId),
                    Center(
                      child: Text(''),
                    ),
                  ]);
                default:
                  return Center(child: CircularProgressIndicator());
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
