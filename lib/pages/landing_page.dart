// // import 'package:business_chat/constants/routes.dart';
// // import 'package:flutter/material.dart';

// // class LandingPage extends StatelessWidget {
// //   const LandingPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Column(
// //         children: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pushNamed(context, joinRoomRoute);
// //             },
// //             child: Text("Join Room"),
// //             style: ButtonStyle(
// //                 backgroundColor: MaterialStatePropertyAll(Colors.amber)),
// //           ),
// //           TextButton(
// //               onPressed: () {
// //                 Navigator.pushNamed(context, createRoomRoute);
// //               },
// //               child: Text("Create Room"),
// //               style: ButtonStyle(
// //                   backgroundColor: MaterialStatePropertyAll(Colors.green)))
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:business_chat/constants/routes.dart';
// import 'package:flutter/material.dart';

// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Gradient background to make it visually appealing
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue.shade200, Colors.blue.shade800],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Title text
//                 Text(
//                   "Welcome to the Chat App!",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 50),

//                 // Join Room Button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     backgroundColor: Colors.amber,
//                     elevation: 5,
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, joinRoomRoute);
//                   },
//                   child: Text(
//                     "Join Room",
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Create Room Button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     backgroundColor: Colors.green,
//                     elevation: 5,
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, createRoomRoute);
//                   },
//                   child: Text(
//                     "Create Room",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 50),

//                 // Additional footer or message (optional)
//                 Text(
//                   "Connect with your team easily by joining or creating a room.",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.8),
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:business_chat/constants/routes.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Gradient background to make it visually appealing
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title text
                Text(
                  "Welcome to the Chat App!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                // Join Room Button with blue color matching the background
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue.shade400, // Updated color
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, joinRoomRoute);
                  },
                  child: Text(
                    "Join Room",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Create Room Button with blue color matching the background
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue.shade600, // Updated color
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, createRoomRoute);
                  },
                  child: Text(
                    "Create Room",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),

                // Additional footer or message (optional)
                Text(
                  "Connect with your team easily by joining or creating a room.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
