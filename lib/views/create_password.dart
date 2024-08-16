import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  String email = Get.arguments["email"];
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> password = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: const Color(0xFFFCFCFD),
          appBar: AppBar(
            automaticallyImplyLeading: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.06,
                  right: MediaQuery.of(context).size.width*0.06,
                  top: MediaQuery.of(context).size.width*0.26
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Create Your Password",
                        style :TextStyle(
                            fontSize: MediaQuery.of(context).size.width*0.067,
                            fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width*0.25),
                  Form(
                    key: password,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "please enter a password";
                        }
                        if (val.length < 6) {
                          return "the password must at least contain 6 characters";
                        }
                        else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                        hintText: "password",
                        prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*0.03,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xFF96979B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0), // Adjust the radius as needed
                        ),
                        child: const Text("Submit", style: TextStyle(color: Color(0xFF646469))),
                        onPressed: () {
                          if (password.currentState!.validate()) {
                            Get.toNamed('/other_sign_in_data' , arguments: {
                              'password': passwordController.text ,
                              'email' : email
                            });
                          }
                        },
                      )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By tapping submit , you accept [app name]'s",
                        style: TextStyle(
                            fontSize:  MediaQuery.of(context).size.width*0.031,
                        ),
                      ),
                      Text(
                        " terms of use",
                        style: TextStyle(color: Color(0xFF3742FA),
                          fontSize: MediaQuery.of(context).size.width*0.031,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.23),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("I already have an account ? "),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed('/login');
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(color: Color(0xFF3742FA)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
