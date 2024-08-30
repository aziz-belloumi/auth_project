import 'package:convergeimmob/authServices/bloc/forgot_password_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({super.key});

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  TextEditingController emailController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit,AuthState>(
      listener : (context , state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        }
        else if (state is AuthSuccess) {
          Get.toNamed('/forgot_password_code' , arguments: {
            "email" : emailController.text,
            "token" : context.read<ForgotPasswordCubit>().token
          });
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
            "Forgot Password",
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
                        "assets/icons/forgot_pass.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
                const Text("Please Enter An Existing Email"),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
                Form(
                    child: TextFormField(
                      controller: emailController,
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: "Email",
                      ),
                    )
                ),
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
                      child: const Text("Send The Code",
                          style: TextStyle(
                              color: Color(0xFF646469), fontFamily: 'Inter')),
                      onPressed: () {
                        context.read<ForgotPasswordCubit>().forgotPassword(emailController.text);
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
