import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeViewThree extends StatelessWidget {
  const WelcomeViewThree({super.key});
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
                      Get.offNamed(
                        '/login' ,
                      );
                    },
                    child: const Text("skip" , style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.4 ,
                width: MediaQuery.of(context).size.width*0.7,
                child: Image.asset(
                  "assets/icons/calendar.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Schedule a Tour",
                style:TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width*0.06,
                    fontWeight: FontWeight.bold
                ) ,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.008,),
              Text(
                  "See Before You Rent",
                  style:TextStyle(
                      color: Colors.black87,
                      fontSize: MediaQuery.of(context).size.width*0.045,
                      fontWeight: FontWeight.w700
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.085),
              Text(
                "Book tours directly through the app to visit properties at your convenience. Get a feel for the place and meet the owners or agents before making a decision",
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
