import 'package:convergeimmob/shared/reply_card.dart';
import 'package:convergeimmob/shared/send_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateMessageView extends StatefulWidget {
  const PrivateMessageView({super.key});

  @override
  State<PrivateMessageView> createState() => _PrivateMessageViewState();
}

class _PrivateMessageViewState extends State<PrivateMessageView> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            SizedBox(width: size.width * 0.04), // Add some spacing between the avatar and text
            const Text("Name"),
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
                SendCard(),
                SendCard(),
                ReplyCard(),
                SendCard(),
                SendCard(),

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
                              // other message logic for sending
                              _messageController.clear();
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
