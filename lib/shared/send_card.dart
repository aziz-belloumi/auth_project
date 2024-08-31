import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SendCard extends StatelessWidget {
  const SendCard({required this.message ,super.key});
  final String? message ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
        ),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.008 , horizontal : size.width * 0.03),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.zero, // No rounding for the bottom right corner
            ),
          ),
          color: AppColors.bluePrimaryLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01 , horizontal : size.width * 0.035),
                child: Text(
                  message!,
                  style: TextStyle(
                    fontSize: size.height * 0.02 ,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
