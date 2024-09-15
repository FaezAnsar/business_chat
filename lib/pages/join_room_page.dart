// import 'package:business_chat/crud/cloud_class.dart';
// import 'package:business_chat/pop_ups/room%20_not_joined_pop_up.dart';
// import 'package:business_chat/pop_ups/room_joined_pop_up.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class JoinRoomPage extends StatelessWidget {
//   JoinRoomPage({super.key});

//   final TextEditingController _employeeName = TextEditingController();
//   final TextEditingController _employeeCnic = TextEditingController();
//   final TextEditingController _employeeRole = TextEditingController();
//   final TextEditingController _orgKey = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             TextFormField(
//               controller: _employeeName,
//               decoration: InputDecoration(
//                   hintText: "Enter your  Name", labelText: "Employee Name"),
//             ),
//             TextFormField(
//               controller: _employeeCnic,
//               decoration: InputDecoration(
//                   hintText: "Enter your CNIC", labelText: "Employee Cnic"),
//             ),
//             TextFormField(
//               controller: _employeeRole,
//               decoration: InputDecoration(
//                   hintText: "Enter your role ",
//                   labelText: "Role in Organisation"),
//             ),
//             TextFormField(
//               controller: _orgKey,
//               decoration: InputDecoration(
//                   hintText: "Enter Organisation's key",
//                   labelText: "Organisation's key"),
//             ),
//             Center(
//                 child: TextButton(
//               onPressed: () async {
//                 final user = FirebaseAuth.instance.currentUser!;
//                 final email = user.email!;

//                 final Map<String, String> map = {
//                   'type': 'join',
//                   organisationIdField: _orgKey.text,
//                   emailField: email,
//                   nameField: _employeeName.text,
//                   roleField: _employeeRole.text,
//                   employeeCnicField: _employeeCnic.text
//                 };

//                 if (await organisationNotPresent(map)) {
//                   RoomNotJoinedPopUp(context, map);
//                 } else {
//                   if ((await isalreadyJoined(user, map))) {
//                     map.addEntries({alreadyJoined: 'Yes'}.entries);
//                     RoomJoinedPopUp(context, map);
//                   } else {
//                     map.addEntries({alreadyJoined: 'No'}.entries);
//                     RoomJoinedPopUp(context, map);
//                   }
//                 }
//               },
//               style: ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Colors.amber)),
//               child: Text("Join Room"),
//             ))
//           ],
//         ));
//   }
// }
import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/pop_ups/room%20_not_joined_pop_up.dart';
import 'package:business_chat/pop_ups/room_joined_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoinRoomPage extends StatelessWidget {
  JoinRoomPage({super.key});

  final TextEditingController _employeeName = TextEditingController();
  final TextEditingController _employeeCnic = TextEditingController();
  final TextEditingController _employeeRole = TextEditingController();
  final TextEditingController _orgKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Join Room"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: Container(
        width: double.infinity, // Full width
        height: double.infinity, // Full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          // To prevent overflow when keyboard pops up or content is larger
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Join Your Organisation's Room",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _employeeName,
                label: "Employee Name",
                hintText: "Enter your name",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _employeeCnic,
                label: "Employee CNIC",
                hintText: "Enter your CNIC",
                icon: Icons.credit_card,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _employeeRole,
                label: "Role in Organisation",
                hintText: "Enter your role",
                icon: Icons.work_outline,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _orgKey,
                label: "Organisation's Key",
                hintText: "Enter organisation's key",
                icon: Icons.vpn_key,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue.shade600,
                    elevation: 5,
                  ),
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser!;
                    final email = user.email!;

                    final Map<String, String> map = {
                      'type': 'join',
                      organisationIdField: _orgKey.text,
                      emailField: email,
                      nameField: _employeeName.text,
                      roleField: _employeeRole.text,
                      employeeCnicField: _employeeCnic.text
                    };

                    if (await organisationNotPresent(map)) {
                      RoomNotJoinedPopUp(context, map);
                    } else {
                      if ((await isalreadyJoined(user, map))) {
                        map.addEntries({alreadyJoined: 'Yes'}.entries);
                        RoomJoinedPopUp(context, map);
                      } else {
                        map.addEntries({alreadyJoined: 'No'}.entries);
                        RoomJoinedPopUp(context, map);
                      }
                    }
                  },
                  child: const Text(
                    "Join Room",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create text fields with icons and consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue.shade800),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}
