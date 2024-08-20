import 'package:convergeimmob/authServices/bloc/facebook_cubit.dart';
import 'package:convergeimmob/authServices/bloc/google_cubit.dart';
import 'package:convergeimmob/authServices/bloc/log_in_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool checkStatus = false;
  bool passwordStatus = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogInCubit, AuthState>(listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is AuthSuccess) {
            Get.offAllNamed('/home');
          }
          else if (state is AuthError) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 3),
                backgroundColor: AppColors.bluebgNavItem,
              ),
            );
          }
        }),
        BlocListener<GoogleCubit, AuthState>(
            listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is AuthSuccess) {
            Get.offAllNamed('/home');
          }
          else if (state is AuthError) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 3),
                backgroundColor: AppColors.bluebgNavItem,
              ),
            );
          }
        }),
        BlocListener<FacebookCubit, AuthState>(listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is AuthSuccess) {
            Get.offAllNamed('/home');
          } else if (state is AuthError) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 3),
                backgroundColor: AppColors.bluebgNavItem,
              ),
            );
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFD),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offNamed('/home');
                      },
                      child: const Text(
                        "skip",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.width * 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back !",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: MediaQuery.of(context).size.width * 0.073,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: "Email",
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: passwordStatus,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordStatus = !passwordStatus;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_outlined),
                          ),
                          hintText: "Password",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                      child: Checkbox(
                        value: checkStatus,
                        onChanged: (value) {
                          setState(() {
                            checkStatus = value!;
                          });
                        },
                      ),
                    ),
                    const Text(
                      "Remember Me",
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.24,
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed('/contact');
                        },
                        child: const Text(
                          "Forgot Password ?",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.015,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: FloatingActionButton(
                      hoverColor: Colors.red,
                      backgroundColor: (emailController.text.isNotEmpty && passwordController.text.isNotEmpty)? AppColors.bluebgNavItem : AppColors.greyDescribePropertyItem,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                          "Continue",
                          style: TextStyle(
                              color: (emailController.text.isNotEmpty && passwordController.text.isNotEmpty)? AppColors.white : AppColors.grey,
                              fontFamily: 'Inter'
                          )
                      ),
                      onPressed: () {
                        context.read<LogInCubit>().logIn(emailController.text, passwordController.text, prefs);
                      },
                    )
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By tapping Continue, I accept HomeFind's ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.0315,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        //Get.toNamed('/reset_password');
                      },
                      child: Text(
                        "Terms Of Use",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFF1E3FE5),
                          decorationThickness:
                              MediaQuery.of(context).size.height * 0.003,
                          color: const Color(0xFF1E3FE5),
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: MediaQuery.of(context).size.width * 0.0047,
                        color: Colors.black,
                        height: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.015,
                      ),
                      child: const Text("Or",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: MediaQuery.of(context).size.width * 0.0047,
                        color: Colors.black,
                        height: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: Platform.isIOS
                      ? [
                          CircularImageButton(
                              imagePath: 'assets/google_logo.png',
                              onPressed: () {},
                              radiusValue: 22),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircularImageButton(
                              imagePath: 'assets/icons/facebook.png',
                              onPressed: () {},
                              radiusValue: 24),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          CircularImageButton(
                              imagePath: 'assets/icons/apple.png',
                              onPressed: () {},
                              radiusValue: 30),
                        ]
                      : [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: FloatingActionButton.extended(
                              onPressed: () async {
                                context.read<GoogleCubit>().signInWithGoogle();
                              },
                              icon: Image.asset(
                                'assets/icons/google_logo.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.033,
                                width: MediaQuery.of(context).size.width * 0.07,
                                fit: BoxFit.cover,
                              ),
                              label: const Text(
                                "Google",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust border radius as needed
                                side: const BorderSide(
                                    color: Colors.grey,
                                    width:
                                        2.0), // Adjust border color and width
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: FloatingActionButton.extended(
                              onPressed: () async {
                                context.read<FacebookCubit>().signInWithFacebook();
                              },
                              icon: Image.asset(
                                'assets/icons/facebook.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.033,
                                width: MediaQuery.of(context).size.width * 0.07,
                                fit: BoxFit.cover,
                              ),
                              label: const Text(
                                "Facebook",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust border radius as needed
                                side: const BorderSide(
                                    color: Colors.grey,
                                    width:
                                        2.0), // Adjust border color and width
                              ),
                            ),
                          )
                        ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed('/sign_in');
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: const Color(0xFF1E3FE5),
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularImageButton extends StatelessWidget {
  const CircularImageButton(
      {super.key,
      required this.imagePath,
      required this.onPressed,
      required this.radiusValue});
  final String imagePath;
  final VoidCallback onPressed;
  final double radiusValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: radiusValue,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}
