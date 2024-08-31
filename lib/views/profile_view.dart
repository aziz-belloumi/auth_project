import 'dart:convert';
import 'dart:io';
import 'package:convergeimmob/authServices/bloc/log_out_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? firstName ;
  String? lastName ;
  String? email ;
  String? profilePicture ;
  int? phoneNumber ;


  @override
  void initState(){
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && JwtDecoder.isExpired(token) == false) {
      final decodedToken = JwtDecoder.decode(token);
      setState(() {
        profilePicture = decodedToken['profilePicture'];
        email = decodedToken["email"] ;
        firstName = decodedToken["firstName"];
        lastName = decodedToken["lastName"];
        phoneNumber = decodedToken["numTel"] ;
      });
    }
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);
      String uploadUrl = 'http://192.168.54.133/api/userData/upload-picture'; // Replace with your actual backend URL

      try {
        var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
        request.fields['email'] = email!;
        var fileStream = http.ByteStream(imageFile.openRead());
        var fileLength = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'profileImage',
          fileStream,
          fileLength,
          filename: imageFile.path.split('/').last,
        );
        request.files.add(multipartFile);
        var response = await request.send();
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          final Map<String, dynamic> responseJson = jsonDecode(responseBody);
          final newProfilePicture = responseJson['profilePicture'];
          final newToken = responseJson['token'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', newToken);
          setState(() {
            profilePicture = newProfilePicture; // Update with the new profile picture URL
          });
        }
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }


  Future<void> _editInfo(String oldEmail, String? newEmail,String? firstName, String? lastName, int? numTel) async {
    try{
      var reqBody = {
        "oldEmail": oldEmail,
        "newEmail": newEmail,
        "firstName": firstName ,
        "lastName": lastName ,
        "numTel": numTel
      };
      var response = await http.post(
          Uri.parse("http://10.0.2.2:4050/api/userData/edit-data"),
          headers: { "Content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        var jsonResponse = jsonDecode(response.body);
        var myToken = jsonEncode({
          "token" : jsonResponse["token"],
        });
        if (JwtDecoder.isExpired(myToken) == false) {
          final decodedToken = JwtDecoder.decode(myToken);
          setState(() {
            this.email = decodedToken["email"] ;
            this.firstName = decodedToken["firstName"];
            this.lastName = decodedToken["lastName"];
            this.phoneNumber = decodedToken["numTel"] ;
          });
          await prefs.setString('token', myToken);
        }
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.offAllNamed("/home");
          },
          child: const Icon(
            Icons.arrow_back
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width*0.06,
              right: MediaQuery.of(context).size.width*0.06
          ),
          child: BlocListener<LogOutCubit,AuthState>(
            listener: (context,state){
              if (state is AuthLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );
              }
              else if (state is AuthInitial) {
                Get.offAllNamed('/login');
              }
              else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            child: Stack(
                              children:[
                                CircleAvatar(
                                  radius: size.width*0.16,
                                  backgroundImage: profilePicture != null && profilePicture!.isNotEmpty
                                      ? NetworkImage(profilePicture!)
                                      : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ]
                            ),
                            onLongPress: (){
                              _changeProfilePicture();
                            },
                          ),
                          Text(
                            "$firstName",
                            style: const TextStyle(color: AppColors.black,fontSize:20 ,fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "$email",
                            style: const TextStyle(color: AppColors.black , fontSize:15),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: size.height*0.06,),
                  const Text(
                    "Personal Data",
                    style: TextStyle(color: AppColors.black,fontSize:18 ,fontWeight: FontWeight.w500)
                  ) ,
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "$firstName"
                          ),
                          controller: firstNameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "$lastName"
                          ),
                          controller: lastNameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "$email"
                          ),
                          controller: emailController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "$phoneNumber"
                          ),
                          controller: phoneController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03,),
                  SizedBox(
                    width: size.width ,
                    child: Expanded(
                      child: FloatingActionButton.extended(
                        elevation: 0.0,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: AppColors.bluebgNavItem,
                            width: size.width*0.005,
                          ),
                        ),
                        label: const Text(
                          "Edit Information", style: TextStyle(color: AppColors.bluebgNavItem),
                        ),
                        onPressed:(){
                          _editInfo(
                              email!, emailController.text.isNotEmpty ? emailController.text : this.email ,
                              firstNameController.text.isNotEmpty ? firstNameController.text : this.firstName,
                              lastNameController.text.isNotEmpty ? lastNameController.text : this.lastName,
                              phoneController.text.isNotEmpty ? int.parse(phoneController.text) : this.phoneNumber
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Divider(
                    color: AppColors.black, // Color of the line
                    thickness: size.width*0.003,        // Thickness of the line// Right padding
                  ),
                  SizedBox(height: size.height * 0.02,),
                  const Text(
                      "Personal Data",
                      style: TextStyle(color: AppColors.black,fontSize:18 ,fontWeight: FontWeight.w500)
                  ) ,
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Current Plan"
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Renewal Date"
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03,),
                  SizedBox(
                    width: size.width ,
                    child: Expanded(
                      child: FloatingActionButton.extended(
                        elevation: 0.0,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: AppColors.bluebgNavItem,
                            width: size.width*0.005,
                          ),
                        ),
                        label: const Text(
                          "Manage Subscription", style: TextStyle(color: AppColors.bluebgNavItem),
                        ),
                        onPressed:(){},
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Divider(
                    color: AppColors.black, // Color of the line
                    thickness: size.width*0.003,        // Thickness of the line// Right padding
                  ),
                  SizedBox(height: size.height * 0.01,),
                  const Text(
                      "Legal",
                      style: TextStyle(color: AppColors.black,fontSize:18 ,fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: size.height * 0.02,),
                  GestureDetector(
                    onTap: (){},
                    child: const Text(
                      "Terms of Service"
                    ),
                  ),
                  Divider(
                    color: AppColors.greyDescribePropertyItem, // Color of the line
                    thickness: size.width*0.003,        // Thickness of the line// Right padding
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: const Text(
                        "Privacy Policy"
                    ),
                  ),
                  Divider(
                    color: AppColors.greyDescribePropertyItem, // Color of the line
                    thickness: size.width*0.003,        // Thickness of the line// Right padding
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Divider(
                    color: AppColors.black, // Color of the line
                    thickness: size.width*0.003,        // Thickness of the line// Right padding
                  ),
                  SizedBox(height: size.height * 0.01,),
                  const Text(
                      "Need Help?",
                      style: TextStyle(color: AppColors.black,fontSize:18 ,fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: size.height * 0.03,),
                  SizedBox(
                    width: size.width ,
                    child: Expanded(
                      child: FloatingActionButton.extended(
                        elevation: 0.0,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: AppColors.bluebgNavItem,
                            width: size.width*0.005,
                          ),
                        ),
                        label: const Text(
                          "Contact Support", style: TextStyle(color: AppColors.bluebgNavItem),
                        ),
                        onPressed:(){},
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  SizedBox(
                    width: size.width ,
                    child: Expanded(
                      child: FloatingActionButton.extended(
                        elevation: 0.0,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: AppColors.bluebgNavItem,
                            width: size.width*0.005,
                          ),
                        ),
                        label: const Text(
                          "FAQ", style: TextStyle(color: AppColors.bluebgNavItem),
                        ),
                        onPressed:(){},
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  SizedBox(
                    width: size.width ,
                    child: Expanded(
                      child: FloatingActionButton.extended(
                        icon: const Icon(
                          Icons.logout,
                          color: AppColors.white,
                        ),
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
                          "Log out", style: TextStyle(color: AppColors.white),
                        ),
                        onPressed:(){
                          context.read<LogOutCubit>().logOut() ;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
