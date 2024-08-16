import 'dart:convert';
import 'dart:io';
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

  String? firstName ;
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
        phoneNumber = decodedToken["numTel"] ;
      });
    }
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);
      String uploadUrl = 'http://192.168.40.133:4050/api/auth/upload-picture'; // Replace with your actual backend URL

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.offAllNamed("/home_screen");
          },
          child: const Icon(
            Icons.arrow_back
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*0.06,
            right: MediaQuery.of(context).size.width*0.06
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: size.width*0.16,
                        backgroundImage: profilePicture != null && profilePicture!.isNotEmpty
                            ? NetworkImage(profilePicture!)
                            : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
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
                style: const TextStyle(color: AppColors.black,fontSize:18 ,fontWeight: FontWeight.w500)
              ) ,
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "$firstName"
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "$email"
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "$phoneNumber"
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                      onPressed:(){},
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                        "Change Profile Picture", style: TextStyle(color: AppColors.bluebgNavItem),
                      ),
                      onPressed:(){
                        _changeProfilePicture();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
