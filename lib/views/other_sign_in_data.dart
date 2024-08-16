import 'package:convergeimmob/authServices/bloc/sign_up_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class OtherSignInData extends StatefulWidget {
  const OtherSignInData({super.key});
  @override
  State<OtherSignInData> createState() => _OtherSignInDataState();
}
class _OtherSignInDataState extends State<OtherSignInData> {
  String email = Get.arguments["email"];
  String password = Get.arguments["password"];
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<String> items = ['+216', '+217', '+218','+219', '+220', '+221','+222', '+223', '+224',];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit,AuthState>(
      listener: (context ,state){
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        }
        else if (state is AuthSuccess) {
          Get.offAllNamed('/login');
        }
        else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFD),
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*0.06,
                right: MediaQuery.of(context).size.width*0.06,
                top: MediaQuery.of(context).size.width*0.2
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Almost there !",
                  style :TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.067,
                      fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.12,),
                Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: textInputDecoration.copyWith(
                                prefixIcon: Icon(Icons.person_2_outlined),
                                hintText: "First Name",
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.height*0.02,),
                          Expanded(
                            child: TextFormField(
                              controller: lastNameController,
                              decoration: textInputDecoration.copyWith(
                                prefixIcon: Icon(Icons.person_2_outlined),
                                hintText: "Last Name",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "+216",
                                      style: TextStyle(
                                        fontSize:MediaQuery.of(context).size.height*0.02,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              items: items.map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              )).toList(),
                              value: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: MediaQuery.of(context).size.height*0.068,
                                width: MediaQuery.of(context).size.width*0.24,
                                padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.028 ,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: MediaQuery.of(context).size.width*0.0024,
                                    color: Colors.grey,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                iconSize:MediaQuery.of(context).size.width*0.075,
                                iconEnabledColor: Colors.grey,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: MediaQuery.of(context).size.height*0.25,
                                width: MediaQuery.of(context).size.height*0.115,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                offset: const Offset(0, 0), // this one is for controlling how to display the items
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(4),
                                  // thickness: WidgetStateProperty.all<double>(MediaQuery.of(context).size.width*0.017),
                                  // thumbVisibility: WidgetStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                height: MediaQuery.of(context).size.height*0.05,
                                padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.028 ,),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: textInputDecoration.copyWith(
                                prefixIcon: Icon(Icons.phone_outlined),
                                hintText: "Phone Number",
                            ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: FloatingActionButton(
                            backgroundColor: const Color(0xFF96979B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0), // Adjust the radius as needed
                            ),
                            child: const Text("Continue",style: TextStyle(color: Color(0xFF646469)) ),
                            onPressed: (){
                              context.read<SignUpCubit>().signUp(email, password, firstNameController.text, lastNameController.text, int.parse(phoneController.text), false, "123", "456");
                            },
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
