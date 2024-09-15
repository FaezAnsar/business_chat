// import 'package:business_chat/crud/cloud_class.dart';
// import 'package:business_chat/pop_ups/room_creation_pop_up.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class CreateRoomPage extends StatelessWidget {
//   final TextEditingController _ownerName = TextEditingController();
//   final TextEditingController _ownerCnic = TextEditingController();
//   final TextEditingController _orgName = TextEditingController();

//   CreateRoomPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             TextFormField(
//               controller: _ownerName,
//               decoration: InputDecoration(
//                   hintText: "Enter Owner Name", labelText: "Owner Name"),
//               // validator: (value) {
//               //   if (value == null) return "Field can't be empty";
//               //   return value;
//               // },
//             ),
//             TextFormField(
//               controller: _ownerCnic,
//               decoration: InputDecoration(
//                   hintText: "Enter Owner CNIC", labelText: "Owner Cnic"),
//               // validator: (value) {
//               //   if (value == null)
//               //     return "Field can't be empty";
//               //   else if (value.length < 15) return "Enter 15 digits";
//               //   return value;
//               // },
//             ),
//             TextFormField(
//               controller: _orgName,
//               decoration: InputDecoration(
//                   hintText: "Enter Organisation's Name",
//                   labelText: "Organisation's Name"),
//             ),
//             Center(
//               child: TextButton(
//                 onPressed: () async {
//                   final email = await FirebaseAuth.instance.currentUser!.email!;

//                   final Map<String, String> map = {
//                     'type': 'create',
//                     emailField: email,
//                     nameField: _orgName.text,
//                     ownerNameField: _ownerName.text,
//                     ownerCnicField: _ownerCnic.text
//                   };
//                   RoomCreationPopUp(context, map);
//                 },
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(Colors.amber)),
//                 child: Text("Create Room"),
//               ),
//             )
//           ],
//         ));
//   }
// }
import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/pop_ups/room_creation_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateRoomPage extends StatelessWidget {
  final TextEditingController _ownerName = TextEditingController();
  final TextEditingController _ownerCnic = TextEditingController();
  final TextEditingController _orgName = TextEditingController();

  CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create Room"),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create a New Organisation Room",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _ownerName,
                label: "Owner Name",
                hintText: "Enter Owner Name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _ownerCnic,
                label: "Owner CNIC",
                hintText: "Enter Owner CNIC",
                icon: Icons.credit_card_outlined,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _orgName,
                label: "Organisation Name",
                hintText: "Enter Organisation Name",
                icon: Icons.business_outlined,
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
                    final email =
                        await FirebaseAuth.instance.currentUser!.email!;

                    final Map<String, String> map = {
                      'type': 'create',
                      emailField: email,
                      nameField: _orgName.text,
                      ownerNameField: _ownerName.text,
                      ownerCnicField: _ownerCnic.text
                    };
                    RoomCreationPopUp(context, map);
                  },
                  child: const Text(
                    "Create Room",
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
