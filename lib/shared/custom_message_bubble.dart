import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Get.toNamed('/private_message');
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
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            SizedBox(width: size.width * 0.04), // Space between avatar and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: size.height * 0.023,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    "Last message",
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