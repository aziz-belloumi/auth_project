import 'dart:convert';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:convergeimmob/shared/custom_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  List<dynamic> users = [];
  String? sourceId ;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }
  Future<void> _getAllUsers() async {
    try{
      final response = await http.post(
          Uri.parse("http://10.0.2.2:4050/api/userData/bring-allUsers"),
          headers: {"Content-Type": "application/json"},
          body : jsonEncode({
            'id' : sourceId
          })
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          users = responseData['users'];
        });
      }
    }
    catch(e){
      print(e);
    }
  }
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && JwtDecoder.isExpired(token) == false) {
      final decodedToken = JwtDecoder.decode(token);
      setState(() {
        sourceId = decodedToken['_id'];
      });
      _getAllUsers();
    }
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: size.height * 0.15,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            top: size.width * 0.15,
            left: size.width * 0.06,
            right: size.width * 0.06,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: TextStyle(
                  fontSize: size.height * 0.032,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: searchController,
                decoration: textInputDecoration.copyWith(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                ),
              ),
            ],
          ),
        ),
        bottom: TabBar(
          padding: EdgeInsets.only(
            left: size.width * 0.06,
            right: size.width * 0.06,
          ),
          controller: _tabController,
          tabs: const [
            Tab(child: Text("Messages")),
            Tab(child: Text("Chat Bot")),
          ],
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
            color: AppColors.gNavBgColor,
            borderRadius: BorderRadius.circular(2),
          ),
          labelColor: AppColors.bluebgNavItem,
          unselectedLabelColor: AppColors.greyDescribePropertyItem,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
        ),
        child: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return CustomBubble(
                    firstName: user['firstName'],
                    profilePicture: user['profilePicture'],
                    destinationId: user['_id'],
                    sourceId: sourceId,
                  );
                },
              ),
              const Center(child: Text('Chat Bot Tab')),
            ],
          ),
        ),
      ),
    );
  }
}
