import 'package:convergeimmob/authServices/bloc/reset_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ResetYourPassword extends StatefulWidget {
  const ResetYourPassword({super.key});

  @override
  State<ResetYourPassword> createState() => _ResetYourPasswordState();
}

class _ResetYourPasswordState extends State<ResetYourPassword> {
  String? id = Get.arguments["id"];
  TextEditingController passwordController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit,AuthState>(
      listener : (context , state){
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        }
        else if (state is AuthSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                title: const Icon(
                  Icons.check_circle_rounded,
                  size: 80,
                  color:AppColors.bluebgNavItem  ,
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: const Column(
                    children: [
                      SizedBox(height : 10),
                      Text(
                        "Successful",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height : 10),
                      Text(
                        'Congratulations! Your password has been changed. Click continue to login',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width : MediaQuery.of(context).size.width*0.6 ,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Get.offAllNamed('/login');
                          },
                          label: Text(
                            "Continue",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: MediaQuery.of(context).size.width*0.04 ,
                            ),
                          ),
                          backgroundColor:AppColors.bluebgNavItem ,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        }
        else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Reset Password",
            style: TextStyle(fontWeight : FontWeight.bold),
          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.25 ,
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Image.asset(
                        "assets/icons/reset_pass.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Form(
                    child: TextFormField(
                      controller: passwordController,
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "Password",
                      ),
                    )
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
                      child: const Text("Submit",
                          style: TextStyle(
                              color: Color(0xFF646469), fontFamily: 'Inter')),
                      onPressed: () {
                        context.read<ResetPasswordCubit>().resetPassword(passwordController.text, id!);
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
