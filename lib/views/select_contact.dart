import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  int selectedCardIndex = -1; // Variable to track the selected card index

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(fontSize: size.width * 0.05),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            children: [
              Image.asset(
                'assets/icons/forgot_pass.png',
                width: size.width,
              ),
              const Text(
                "Select which contact details should we use to reset your password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height:size.height*0.02),
              SizedBox(
                height: size.height*0.25,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 2, // Number of selectable options
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCardIndex = index; // Update the selected index
                          });
                        },
                        child: Card(
                          color: selectedCardIndex == index ? AppColors.blueLight : AppColors.white, // Change color if selected
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: selectedCardIndex == index ? AppColors.bluebgNavItem : AppColors.greyDescribePropertyItem,
                              width: 2.0,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(vertical: size.height*0.01),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Icon(
                                  index == 0 ? Icons.email_outlined : Icons.message_outlined,
                                  size: size.width*0.08,
                                  color: selectedCardIndex == index ?  AppColors.black : AppColors.greyDescribePropertyItem,
                                ),
                                SizedBox(width: size.width*0.05),
                                Text(
                                  index == 0 ? 'Via Email' : 'Via SMS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width*0.04,
                                    color: selectedCardIndex == index ? AppColors.black : AppColors.greyDescribePropertyItem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: size.width ,
                child: Expanded(
                  child: FloatingActionButton.extended(
                    elevation: 0.0,
                    backgroundColor: AppColors.bluebgNavItem,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: AppColors.bluebgNavItem,
                        width: size.width*0.005,
                      ),
                    ),
                    label: const Text(
                      "Continue", style: TextStyle(color: AppColors.white),
                    ),
                    onPressed:(){
                      Get.toNamed("/forgot_password" , arguments: {
                        "inputText" : selectedCardIndex == 0 ? "Email" : "Phone Number"
                      }
                      );
                    },
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
