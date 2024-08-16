
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WelcomeViewOne extends StatelessWidget {
  const WelcomeViewOne({super.key,});
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
                  "assets/icons/small_town.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Welcome to HomeFind",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width*0.06,
                  fontWeight: FontWeight.bold
                ) ,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.008,),
              Text(
                "Discover Your Perfect Property",
                style:TextStyle(
                    color: Colors.black87,
                    fontSize: MediaQuery.of(context).size.width*0.045,
                    fontWeight: FontWeight.w700
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.085),
              Text(
                "Explore thousands of rental listing tailored to your needs. Whether you're looking for a cozy apartment in the city or a spacious house in the suburbs, we've got you covered",
                textAlign: TextAlign.center,
                style:TextStyle(
                  //fontFamily: inter,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
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
