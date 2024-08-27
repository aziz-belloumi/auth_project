import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:convergeimmob/shared/custom_message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController() ;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this , initialIndex: 0);
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
          padding:EdgeInsets.only(
            top: size.width * 0.15,
              left: size.width * 0.06,
              right: size.width * 0.06
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
              SizedBox(height: size.height * 0.01,),
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
          padding:EdgeInsets.only(
              left: size.width * 0.06,
              right: size.width * 0.06
        ),
          controller: _tabController, // Set the controller here
          tabs: const [
            Tab(child: Text("Messages")),
            Tab(child: Text("Chat Bot")),
          ],
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
            color: AppColors.gNavBgColor, // Background color of the selected tab
            borderRadius: BorderRadius.circular(2), // Optional: Rounded corners
          ),
          labelColor: AppColors.bluebgNavItem, // Text color for selected tab
          unselectedLabelColor: AppColors.greyDescribePropertyItem,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.06,
            right: size.width * 0.06
        ),
        child: SafeArea(
          child: TabBarView(
            controller: _tabController, // Set the controller here as well
            children: [
              ListView(
                children: <Widget>[
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                  CustomBubble(),
                ],
              ),
              Center(child: Text('Chat Bot Tab')),
            ],
          ),

        ),
      ),
    );
  }
}

