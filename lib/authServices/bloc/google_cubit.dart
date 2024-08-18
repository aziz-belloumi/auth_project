import 'dart:async';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleCubit extends Cubit<AuthState> {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  GoogleCubit() : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(authCredential);
        final currentUser = auth.currentUser;

        final response = await http.post(
          Uri.parse("http://10.0.2.2:4050/api/auth/google"),
          headers: { "Content-Type": "application/json"},
          body: jsonEncode({
            'email': currentUser?.email ?? '',
            'firstName': currentUser?.displayName ?? '',
            'profilePicture': currentUser?.photoURL ?? '',
            'admin' : false
          }),
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", responseData['token']);
          emit(AuthSuccess());
        }
        else {
          emit(AuthError('Auth failed: ${response.reasonPhrase}'));
        }
      }
    } catch (err) {
      emit(AuthError('Auth failed: $err'));
    }
  }
}
