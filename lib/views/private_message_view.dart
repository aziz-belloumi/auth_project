import 'package:convergeimmob/Models/message_model.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/shared/reply_card.dart';
import 'package:convergeimmob/shared/send_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



class PrivateMessageView extends StatefulWidget {
  const PrivateMessageView({super.key});

  @override
  State<PrivateMessageView> createState() => _PrivateMessageViewState();
}

class _PrivateMessageViewState extends State<PrivateMessageView> {
  String? destinationProfilePicture = Get.arguments["destinationProfilePicture"];
  String? firstName = Get.arguments["firstName"];
  String? destinationId = Get.arguments["destinationId"];
  String? sourceId = Get.arguments["sourceId"];
  final TextEditingController _messageController = TextEditingController();
  late IO.Socket socket;
  final List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.54.133:4050", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      socket.emit("start_conversation", {'sourceId': sourceId});
      socket.on("message", (msg) {
        setMessage("destination", msg["message"]);
      });
    });
  }

  void sendMessage(String message, String destinationId, String sourceId) {
    setMessage("source", message);
    socket.emit("message", {'message': message, 'sourceId': sourceId, 'destinationId': destinationId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: size.height * 0.033,
              backgroundImage: destinationProfilePicture != null && destinationProfilePicture!.isNotEmpty
                  ? NetworkImage(destinationProfilePicture!)
                  : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
            ),
            SizedBox(width: size.width * 0.04), // Add some spacing between the avatar and text
            Text(
              "$firstName",
              style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: size.height * 0.1), // Add padding to avoid overlap with the text field
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if (messages[index].type == "source") {
                    return SendCard(message: messages[index].message);
                  } else {
                    return ReplyCard(
                      message: messages[index].message,
                      destinationProfilePicture: destinationProfilePicture,
                    );
                  }
                },
              ),
            ),
            // The message input field
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.01,
                bottom: size.height * 0.01,
                right: size.width * 0.035,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    padding: const EdgeInsets.all(0),
                    iconSize: size.height * 0.04,
                    onPressed: () {
                      // attach some files here
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (_messageController.text.isNotEmpty) {
                              sendMessage(_messageController.text, destinationId!, sourceId!);
                              _messageController.clear();
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: AppColors.greyDescribePropertyItem,  // You can change this to any color you want
                            width: 1.0,          // Set the border thickness to 1
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: AppColors.greyDescribePropertyItem,  // You can change this to any color you want
                            width: 1.0,          // Set the border thickness to 1
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color:AppColors.greyDescribePropertyItem,  // You can change this to the color you want when focused
                            width: 1.0,          // Set the border thickness to 1
                          ),
                        ),
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





// enabledBorder: const OutlineInputBorder(
// borderSide: BorderSide(color : AppColors.greyDescribePropertyItem, width: 1)
// ),
// focusedBorder: const OutlineInputBorder(
// borderSide: BorderSide(color : AppColors.greyDescribePropertyItem, width: 1)
// ),

















// import 'package:convergeimmob/Models/message_model.dart';
// import 'package:convergeimmob/shared/reply_card.dart';
// import 'package:convergeimmob/shared/send_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class PrivateMessageView extends StatefulWidget {
//   const PrivateMessageView({super.key});
//
//   @override
//   State<PrivateMessageView> createState() => _PrivateMessageViewState();
// }
//
// class _PrivateMessageViewState extends State<PrivateMessageView> {
//   String? destinationProfilePicture = Get.arguments["destinationProfilePicture"];
//   String? firstName = Get.arguments["firstName"] ;
//   String? destinationId = Get.arguments["destinationId"] ;
//   String? sourceId = Get.arguments["sourceId"] ;
//   final TextEditingController _messageController = TextEditingController();
//   late IO.Socket socket ;
//   final List<MessageModel> messages = [] ;
//
//   @override
//   void initState(){
//     super.initState() ;
//     connect() ;
//   }
//
//   void connect(){
//     socket = IO.io("http://192.168.54.133:4050" , <String , dynamic> {
//       "transports" : ["websocket"] ,
//       "autoConnect" : false ,
//     });
//     socket.connect();
//     socket.onConnect((data){
//       socket.emit("start_conversation" , {'sourceId' : sourceId});
//       socket.on("message" , (msg){
//         print('received message : $msg');
//         setMessage("destination", msg["message"]);
//       });
//     });
//   }
//
//   void sendMessage(String message , String destinationId , String sourceId){
//     setMessage("source", message);
//     socket.emit("message" , { 'message' : message , 'sourceId' : sourceId , 'destinationId' : destinationId});
//   }
//
//   void setMessage(String type , String message){
//     MessageModel messageModel= MessageModel(type: type, message: message);
//     setState(() {
//       messages.add(messageModel);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size ;
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: size.height * 0.033,
//               backgroundImage: destinationProfilePicture != null && destinationProfilePicture!.isNotEmpty
//                   ? NetworkImage(destinationProfilePicture!)
//                   : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
//             ),
//             SizedBox(width: size.width * 0.04), // Add some spacing between the avatar and text
//             Text(
//               "$firstName",
//               style: TextStyle(
//                 fontSize: size.height * 0.02,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context , index){
//                 if(messages[index].type == "source"){
//                   return SendCard(message: messages[index].message);
//                 }
//                 else{
//                   return ReplyCard(message: messages[index].message , destinationProfilePicture: destinationProfilePicture,);
//                 }
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 right: size.width * 0.035,
//                 bottom: size.height * 0.01,
//               ),
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.attach_file,
//                       ),
//                       padding: const EdgeInsets.all(0),
//                       iconSize:size.height * 0.04,
//                       onPressed: () {
//                         // attach some files here
//                       },
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: _messageController,
//                         decoration: InputDecoration(
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.send),
//                             onPressed: () {
//                               if(_messageController.text.isNotEmpty){
//                                 sendMessage(_messageController.text, destinationId!, sourceId!);
//                                 _messageController.clear();
//                               }
//                             },
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal:size.width * 0.03 ),
//                           hintText: 'Message',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
