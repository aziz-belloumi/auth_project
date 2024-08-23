import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInCubit extends Cubit<AuthState>{
  LogInCubit() : super(AuthInitial());

  Future<void> logIn(String email, String password ,SharedPreferences prefs) async {
    emit(AuthLoading());
    try {
      var reqBody = {
        "email": email,
        "password": password
      };
      var response = await http.post(
          Uri.parse("http://10.0.2.2:4050/api/auth/signin"),
          headers: { "Content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var myToken = jsonEncode({
          "token" : jsonResponse["token"],
        });
        await prefs.setString('token', myToken);// storing the token in preferences
        emit(AuthSuccess());
      }
      else if (response.statusCode == 404) {
        emit(AuthError('Error : This account doesn\'t exists'));
      }
      else if (response.statusCode == 401) {
        emit(AuthError('Error : Wrong password , try again'));
      }
    }
    catch (e) {
      emit(AuthError('Error : $e'));
    }
  }
}