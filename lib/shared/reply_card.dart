import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                Flexible(
                  child: Card(
                    margin: EdgeInsets.only(
                        top: size.height * 0.008,
                        bottom: size.height * 0.008,
                        left: size.width * 0.07
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    color: AppColors.bluebgNavItem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.035),
                          child: Text(
                            "hello",
                            style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -10, // Adjust as needed
              left: 5, // Adjust as needed
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red, // Customize as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
