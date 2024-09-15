import 'package:business_chat/crud/cloud_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key, this.sender, this.receiver});
//   final sender;
//   final receiver;

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   late final FirebaseCloudStorage _chatService;
//   // late final CloudEmployee? _receiver;
//   // late final CloudEmployee? _sender;
//   final TextEditingController _controller = TextEditingController();
//   //late List<CloudMessage> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _chatService = FirebaseCloudStorage();
//   }

//   @override
//   // void didChangeDependencies() async {
//   //   super.didChangeDependencies();
//   //   _receiver = getReceiverName();
//   //   _sender = await getSender();

//   //   //print("Messages length: ${_messages.length}"); // Add this line
//   //   // setState(() {});
//   // }

//   // Future<CloudEmployee> getSender() async {
//   //   print("object");
//   //   final userEmail = FirebaseAuth.instance.currentUser!.email;
//   //   final employees = (await _chatService.getAllEmployees(
//   //           organisationId: _receiver!.organisationId))
//   //       .toList();
//   //   final sender =
//   //       employees.firstWhere((employee) => employee.email == userEmail);

//   //   return sender;
//   // }

//   // CloudEmployee? getReceiverName() {
//   //   print('getting');
//   //   final modalRoute = ModalRoute.of(context);
//   //   if (modalRoute != null) {
//   //     print("hi");
//   //     final args = modalRoute.settings.arguments;
//   //     if (args == null) print("yess");

//   //     if (args != null && args is Map) {
//   //       print("nuiooo");

//   //       final receiver = args['employee'];
//   //       print(receiver);
//   //       print("huaaa");
//   //       return receiver;
//   //     }
//   //   }
//   //   return null;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.receiver.name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: _chatService.getCurrentMessages(
//                     senderId: widget.sender
//                         .id, // Provide a default value or handle appropriately
//                     receiverId: widget.receiver.id,
//                     organisationId: widget.sender.organisationId),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator(); // Loading indicator while waiting for data
//                   } else {
//                     if (snapshot.hasError) {
//                       return Text(
//                           'Error: ${snapshot.error}'); // Handle error state
//                     } else {
//                       return ListView(
//                         padding: EdgeInsets.all(3),
//                         children: snapshot.data!.docs
//                             .map((doc) => Padding(
//                                   padding: EdgeInsets.all(4),
//                                   child: Container(
//                                       constraints: BoxConstraints(maxWidth: 3),
//                                       child: MessageWidget(doc: doc)),
//                                 ))
//                             .toList(),
//                       );
//                     }
//                   }
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(hintText: "Send a message"),
//                       controller: _controller,
//                       onSubmitted: (value) => _controller.clear(),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       await _chatService.sendCloudMessage(
//                           senderEmail: widget.sender!.email,
//                           senderId: widget.sender.id,
//                           receiverId: widget.receiver.id,
//                           message: _controller.text,
//                           organisationId: widget.receiver.organisationId);
//                       _controller.clear();
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.green, shape: BoxShape.circle),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Icon(
//                           Icons.arrow_upward,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MessageWidget extends StatelessWidget {
//   const MessageWidget({super.key, required this.doc});
//   final DocumentSnapshot doc;
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!.email;
//     final currentUser = doc[email] == user;
//     return Flexible(
//       fit: FlexFit.tight,
//       child: Container(
//         constraints: BoxConstraints(maxWidth: 300),
//         alignment: (currentUser) ? Alignment.centerRight : Alignment.centerLeft,
//         padding: EdgeInsets.all(7),
//         color: (currentUser) ? Colors.blueGrey : Colors.amber,
//         child: Text(
//           doc[messageField],
//           // textAlign: (currentUser) ? TextAlign.right : TextAlign.left,
//         ),
//       ),
//     );
//   }
// }
class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.sender, this.receiver});
  final sender;
  final receiver;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final FirebaseCloudStorage _chatService;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatService = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiver.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _chatService.getCurrentMessages(
                  senderId: widget.sender.id,
                  receiverId: widget.receiver.id,
                  organisationId: widget.sender.organisationId,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          return MessageWidget(doc: doc);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No messages yet, start the conversation!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Send a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                      ),
                      controller: _controller,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      if (_controller.text.trim().isNotEmpty) {
                        await _chatService.sendCloudMessage(
                          senderEmail: widget.sender.email,
                          senderId: widget.sender.id,
                          receiverId: widget.receiver.id,
                          message: _controller.text.trim(),
                          organisationId: widget.receiver.organisationId,
                        );
                        _controller.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.doc});
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
    final isCurrentUser = doc['email'] == currentUserEmail;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.blueGrey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isCurrentUser
                ? const Radius.circular(15)
                : const Radius.circular(0),
            bottomRight: isCurrentUser
                ? const Radius.circular(0)
                : const Radius.circular(15),
          ),
        ),
        child: Text(
          doc['message'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
