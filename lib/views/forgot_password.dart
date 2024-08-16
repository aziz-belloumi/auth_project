import 'package:convergeimmob/authServices/bloc/forgot_password_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String inputText = Get.arguments["inputText"];


  TextEditingController fieldController = TextEditingController() ;
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
            "field" : fieldController.text,
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
                Text("Please Enter the $inputText you used when you joined and we'll send you instructions to reset your password"),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
                Form(
                    child: TextFormField(
                      controller: fieldController,
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: inputText == "Email" ? const Icon(Icons.email_outlined) : const Icon(Icons.phone_outlined),
                        hintText: inputText,
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
                      child: const Text("Send",
                          style: TextStyle(
                              color: Color(0xFF646469), fontFamily: 'Inter')),
                      onPressed: () {
                        context.read<ForgotPasswordCubit>().forgotPassword(fieldController.text);
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
