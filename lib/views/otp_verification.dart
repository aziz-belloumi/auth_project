import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.06,vertical:MediaQuery.of(context).size.height*0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Image.asset(
                      "assets/icons/otp_verif.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.03,),
              Text(
                "OTP verification",
                style:TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width*0.067,
                    fontWeight: FontWeight.bold
                ) ,
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.03,),
              Text(
                  "Enter the OTP sent to [your number]",
                  style:TextStyle(
                      color: Colors.black87,
                      fontSize: MediaQuery.of(context).size.width*0.04,
                      letterSpacing: 1
                      //fontWeight: FontWeight.w500
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Didn't you receive the OTP ? ",
                      style:TextStyle(
                          color: Colors.black45,
                          fontSize:MediaQuery.of(context).size.width*0.035,
                          letterSpacing: 1
                        //fontWeight: FontWeight.w500
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      // resend the code
                    },
                    child: Text(
                        "Resend OTP",
                        style:TextStyle(
                            color: Colors.black87,
                            fontSize: MediaQuery.of(context).size.width*0.037,
                            letterSpacing: 1,
                          fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.w500
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.03,),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.14,
                      child: TextFormField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.14,
                      child: TextFormField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.14,
                      child: TextFormField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.14,
                      child: TextFormField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0), // Adjust the radius as needed
                    ),
                    child: const Text("Verify",style: TextStyle(color: Colors.black) ),
                    onPressed: (){
                      // after verification it's going to route to the account
                    },
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
