import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeViewTwo extends StatelessWidget {
  const WelcomeViewTwo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Get.offNamed('/login');
                    },
                    child: const Text("skip" , style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.4 ,
                width: MediaQuery.of(context).size.width*0.7,
                child: Image.asset(
                  "assets/icons/couch.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Find Exactly What You Need",
                style:TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width*0.06,
                    fontWeight: FontWeight.bold
                ) ,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.008,),
              Text(
                  "Smart Search & Filters",
                  style:TextStyle(
                      color: Colors.black87,
                      fontSize: MediaQuery.of(context).size.width*0.045,
                      fontWeight: FontWeight.w700
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.085),
              Text(
                "Use our advanced search tools and filters to narrow down properties by location, price, amenities, and more. Finding your dream home has never been easier",
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600 ,
                  fontSize: MediaQuery.of(context).size.width*0.045,
                ) ,
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
