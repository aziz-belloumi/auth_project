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
          Uri.parse("http://192.168.40.133:4050/api/auth/signin"),
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
    }
    catch (e) {
      emit(AuthError('Sign-up failed: $e'));
    }
  }
}