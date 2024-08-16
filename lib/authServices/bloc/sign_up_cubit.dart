import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpCubit extends Cubit<AuthState> {

  SignUpCubit() : super(AuthInitial()) ;

  Future<void> signUp(String email, String password , String firstName , String lastName, int numTel , bool admin , String lat , String lng ) async {
    emit(AuthLoading());
    try {
      var reqBody = {
        "email" : email ,
        "password" : password ,
        "firstName" : firstName ,
        "lastName" : lastName ,
        "numTel" : numTel ,
        "admin" : admin ,
        "lat" : lat ,
        "lng" : lng
      } ;
      await http.post(Uri.parse("http://192.168.40.133:4050/api/auth/signup"),
          headers: { "Content-Type" : "application/json"},
          body: jsonEncode(reqBody)
      );
      emit(AuthSuccess());
    }
    catch (e) {
      emit(AuthError('Sign-up failed: $e'));
    }
  }
}