import 'dart:convert';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ResetPasswordCubit extends Cubit<AuthState>{
  ResetPasswordCubit() : super(AuthInitial());
   Future<void> resetPassword(String password , String id) async {
     emit(AuthLoading());
     try{
       var reqBody = {
         "password" : password ,
         "id" : id
       };
       var response = await http.post(
           Uri.parse("http://192.168.40.133:4050/api/auth/reset-password"),
           headers: { "Content-Type": "application/json"},
           body: jsonEncode(reqBody)
       );
       if (response.statusCode == 200){
         emit(AuthSuccess());
       }
     }
     catch(e){
       emit(AuthError(e.toString()));
     }
   }
}