import 'dart:convert';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class VerificationCubit extends Cubit<AuthState>{
  String? id ;
  VerificationCubit() : super(AuthInitial());

  Future<void> verifyCode(int code ,String? token) async {
    emit(AuthLoading());
    try{
      var reqBody = {
        "code" : code ,
        "token" : token
      };
      var response = await http.post(
          Uri.parse("http://10.0.2.2:4050/api/auth/verification"),
          headers: { "Content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        id = jsonResponse["id"];
        emit(AuthSuccess());
      }
      else{
        emit(AuthError("Wrong code"));
      }
    }
    catch(e){
      emit(AuthError(e.toString()));
    }
  }
}