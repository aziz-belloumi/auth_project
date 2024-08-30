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
  String? profilePicture = Get.arguments["profilePicture"];
  String? firstName = Get.arguments["firstName"] ;
  String? destinationId = Get.arguments["destinationId"] ;
  String? sourceId = Get.arguments["sourceId"] ;
  final TextEditingController _messageController = TextEditingController();
  late IO.Socket socket ;

  @override
  void initState(){
    super.initState() ;
    connect() ;
  }

  void connect(){
    socket = IO.io("http://10.0.2.2:4050" , <String , dynamic> {
      "transports" : ["websocket"] ,
      "autoConnect" : false ,
    });
    socket.connect();
    socket.emit("start_conversation" , {'destinationId' : destinationId});
    socket.onConnect((data){
      socket.on('message' , (msg){
        print(msg);
      });
    });
  }

  void sendMessage(String message , String destinationId , String sourceId){
    socket.emit("message" , { 'message' : message , 'sourceId' : sourceId , 'destinationId' : destinationId});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: profilePicture != null && profilePicture!.isNotEmpty
                  ? NetworkImage(profilePicture!)
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
        child: Stack(
          children: [
            ListView(
              children: [
                SendCard(),
                SendCard(),
                SendCard(),
                ReplyCard(),
                ReplyCard(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.035,
                bottom: size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.attach_file,
                      ),
                      padding: const EdgeInsets.all(0),
                      iconSize:size.height * 0.04,
                      onPressed: () {
                        // attach some files here
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if(_messageController.text.isNotEmpty){
                                sendMessage(_messageController.text, destinationId!, sourceId!);
                                _messageController.clear();
                              }
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal:size.width * 0.03 ),
                          hintText: 'Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
