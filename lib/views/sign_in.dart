import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';


class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> email = GlobalKey() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color(0xFFFCFCFD),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.06,
                  right: MediaQuery.of(context).size.width*0.06
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Get.toNamed('/home');
                        },
                        child: const Text("skip" , style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to HomeFind",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.067,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.07),
                  Form(
                    key: email,
                    child: TextFormField(
                      controller: emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "enter an email";
                        }
                        if (!(val.contains("@") && val.contains("."))) {
                          return "please enter a valid form" ;
                        }
                        else{
                          return null ;
                        }
                      },
                      decoration: textInputDecoration.copyWith(
                        hintText: "email",
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600]),
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height*0.035, 0, 0),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xFF96979B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0), // Adjust the radius as needed
                      ),
                      child: const Text("Continue",style: TextStyle(color: Color(0xFF646469)) ),
                      onPressed: (){
                        if(email.currentState!.validate()){
                          Get.toNamed('/create_password' , arguments: {
                            'email': emailController.text
                          });
                        }
                      },
                    )
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:Divider(
                          thickness: MediaQuery.of(context).size.height*0.0022,
                          color: Colors.black,
                          height:MediaQuery.of(context).size.height*0.06,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.015,),
                        child: const Text(
                          "Or",
                          style: TextStyle(fontWeight: FontWeight.w500)
                        ),
                      ),
                      Expanded(
                        child:Divider(
                          thickness: MediaQuery.of(context).size.height*0.0022,
                          color: Colors.black,
                          height:MediaQuery.of(context).size.height*0.06,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: FloatingActionButton.extended(
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size:  MediaQuery.of(context).size.width*0.085,
                        ),
                        backgroundColor: const Color(0xFF1877F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        ),
                        label: const Text("Continue with Facebook",style: TextStyle(color: Colors.white),),
                        onPressed: (){},
                      )
                  ),
                  Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                      width: MediaQuery.of(context).size.width*0.9,
                      child: FloatingActionButton.extended(
                        icon: Image.asset(
                          'assets/icons/google_logo.png',
                          height:MediaQuery.of(context).size.height*0.0327,
                          width:MediaQuery.of(context).size.width*0.065,
                          fit: BoxFit.cover,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        ),
                        label: const Text("Continue with Google",style: TextStyle(color: Colors.black),),
                        onPressed: (){},
                      )
                  ),
                  if (Platform.isIOS)
                    Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                        width: MediaQuery.of(context).size.width*0.9,
                        child: FloatingActionButton.extended(
                          icon: Icon(
                            Icons.apple,
                            color: Colors.white,
                            size:  MediaQuery.of(context).size.width*0.1,
                          ),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                          label: const Text("Continue with Apple",style: TextStyle(color: Colors.white),),
                          onPressed: (){},
                        )
                    ),
                  SizedBox(height:MediaQuery.of(context).size.height*0.09),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("I already have an account ?"),
                      GestureDetector(
                        child: const Text("Log in" , style: TextStyle(color: Color(0xFF3742FA)),),
                        onTap: (){
                          Get.offNamed('/login');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
