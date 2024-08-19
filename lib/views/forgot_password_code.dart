import 'package:convergeimmob/authServices/bloc/forgot_password_cubit.dart';
import 'package:convergeimmob/authServices/bloc/verification_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


class ForgotPasswordCode extends StatefulWidget {
  const ForgotPasswordCode({super.key});

  @override
  State<ForgotPasswordCode> createState() => _ForgotPasswordCodeState();
}

class _ForgotPasswordCodeState extends State<ForgotPasswordCode> {
  String? field = Get.arguments["field"];
  String? token = Get.arguments["token"];

  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit,AuthState>(
      listener: (context,state){
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        }
        else if (state is AuthSuccess) {
          Get.toNamed('/reset_password' , arguments: {
            "id" : context.read<VerificationCubit>().id
          });
        }
        else if (state is AuthError) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.bluebgNavItem,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Verify Your Code",
            style: TextStyle(fontWeight : FontWeight.bold),
          ),
          centerTitle: true ,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
                Text("Code has been sent to $field"),
                SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.12,
                        width: MediaQuery.of(context).size.width*0.14,
                        child: TextFormField(
                          controller: firstController,
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.headlineLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.12,
                        width: MediaQuery.of(context).size.width*0.14,
                        child: TextFormField(
                          controller: secondController,
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.headlineLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.12,
                        width: MediaQuery.of(context).size.width*0.14,
                        child: TextFormField(
                          controller: thirdController,
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.headlineLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.12,
                        width: MediaQuery.of(context).size.width*0.14,
                        child: TextFormField(
                          controller: fourthController,
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.headlineLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: FloatingActionButton(
                      hoverColor: Colors.red,
                      backgroundColor: const Color(0xFF96979B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            4.0), // Adjust the radius as needed
                      ),
                      child: const Text("Verify",
                          style: TextStyle(
                              color: Color(0xFF646469), fontFamily: 'Inter')),
                      onPressed: () {
                        context.read<VerificationCubit>().verifyCode(int.parse(firstController.text + secondController.text + thirdController.text + fourthController.text), token) ;
                      },
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
