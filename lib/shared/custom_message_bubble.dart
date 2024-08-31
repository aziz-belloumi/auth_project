import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBubble extends StatelessWidget {
  final String? firstName ;
  final String? destinationProfilePicture ;
  final String? destinationId ;
  final String? sourceId ;
  const CustomBubble({super.key, required this.destinationId , required this.sourceId ,required this.firstName , required this.destinationProfilePicture});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Get.toNamed('/private_message', arguments: {
          "destinationProfilePicture" : destinationProfilePicture ,
          "firstName" : firstName ,
          "destinationId" : destinationId ,
          "sourceId" : sourceId
        });
      },
      child: Container(
        height: size.height * 0.135,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: size.height * 0.035,
                  backgroundImage: destinationProfilePicture != null && destinationProfilePicture!.isNotEmpty
                      ? NetworkImage(destinationProfilePicture!)
                      : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
                ),
              ],
            ),
            SizedBox(width: size.width * 0.04), // Space between avatar and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$firstName",
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    "last message",
                    style: TextStyle(
                      fontSize: size.height * 0.018,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                    fontSize: size.height * 0.018,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}