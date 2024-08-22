import 'package:convergeimmob/authServices/bloc/facebook_cubit.dart';
import 'package:convergeimmob/authServices/bloc/forgot_password_cubit.dart';
import 'package:convergeimmob/authServices/bloc/google_cubit.dart';
import 'package:convergeimmob/authServices/bloc/log_in_cubit.dart';
import 'package:convergeimmob/authServices/bloc/log_out_cubit.dart';
import 'package:convergeimmob/authServices/bloc/reset_cubit.dart';
import 'package:convergeimmob/authServices/bloc/verification_cubit.dart';
import 'package:convergeimmob/detail_property.dart';
import 'package:convergeimmob/filter_screen.dart';
import 'package:convergeimmob/firebase_options.dart';
import 'package:convergeimmob/home_navigator.dart';
import 'package:convergeimmob/home_screen.dart';
import 'package:convergeimmob/image360_screen.dart';
import 'package:convergeimmob/map_screen.dart';
import 'package:convergeimmob/shared/routing.dart';
import 'package:convergeimmob/views/create_password.dart';
import 'package:convergeimmob/views/forgot_password_code.dart';
import 'package:convergeimmob/views/forgot_password.dart';
import 'package:convergeimmob/views/log_in.dart';
import 'package:convergeimmob/views/other_sign_in_data.dart';
import 'package:convergeimmob/views/otp_verification.dart';
import 'package:convergeimmob/views/profile_view.dart';
import 'package:convergeimmob/views/reset_your_password.dart';
import 'package:convergeimmob/views/select_contact.dart';
import 'package:convergeimmob/views/sign_in.dart';
import 'package:convergeimmob/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_package;
import 'package:convergeimmob/features/immobilier/data/datasources/property_remote_data_source.dart';
import 'package:convergeimmob/features/immobilier/data/repositories/property_repository_impl.dart';
import 'package:convergeimmob/features/immobilier/domain/usecases/add_property_use_case.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authServices/bloc/sign_up_cubit.dart';

void main() async {
  //make sure that the user is logged in
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final myToken = prefs.getString("token");
  // Register dependencies
  final remoteDataSource = PropertyRemoteDataSourceImpl(client: http.Client());
  final repository = PropertyRepositoryImpl(remoteDataSource: remoteDataSource);
  final addPropertyUseCase = AddPropertyUseCase(repository: repository);

  get_package.Get.put(remoteDataSource);
  get_package.Get.put(repository);
  get_package.Get.put(addPropertyUseCase);

  runApp(MyApp(myToken: myToken, addPropertyUseCase: addPropertyUseCase));
}

class MyApp extends StatelessWidget {
  final AddPropertyUseCase addPropertyUseCase;
  final String? myToken;
  const MyApp({required this.myToken, required this.addPropertyUseCase, super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AddPropertyUseCase>(create: (_) => addPropertyUseCase),
        Provider<PropertyBloc>(create: (context) => PropertyBloc(context.read<AddPropertyUseCase>())),
        Provider<SignUpCubit>(create: (context) => SignUpCubit()),
        Provider<LogInCubit>(create: (context) => LogInCubit()),
        Provider<GoogleCubit>(create: (context) => GoogleCubit()),
        Provider<FacebookCubit>(create: (context) => FacebookCubit()),
        Provider<LogOutCubit>(create: (context) => LogOutCubit()),
        Provider<ForgotPasswordCubit>(create: (context) => ForgotPasswordCubit()),
        Provider<VerificationCubit>(create: (context) => VerificationCubit()),
        Provider<ResetPasswordCubit>(create: (context) => ResetPasswordCubit()),
      ],
      child: get_package.GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: (myToken == null || JwtDecoder.isExpired(myToken!)) ? '/login' : '/home',
        getPages: [
          get_package.GetPage(name: '/', page: () => SplashScreen()),
          get_package.GetPage(name: '/routing', page: () => RoutingScreen()),
          get_package.GetPage(
            name: '/login',
            page: () => LogIn(),
            transition: get_package.Transition.fadeIn,
            transitionDuration: Duration(milliseconds: 500),
          ),
          get_package.GetPage(
            name: '/sign_in',
            page: () => SignIn(),
            transition: get_package.Transition.fadeIn,
            transitionDuration: Duration(milliseconds: 500),
          ),
          get_package.GetPage(name: '/create_password', page: () => CreatePassword()),
          get_package.GetPage(name: '/other_sign_in_data', page: () => OtherSignInData()),
          get_package.GetPage(name: '/otp_verif', page: () => OtpVerification()),
          get_package.GetPage(name: '/home', page: () => HomeNavigatorScreen()),
          get_package.GetPage(name: '/detail_property', page: () => DetailProperty()),
          get_package.GetPage(name: '/map_screen', page: () => MapScreen()),
          get_package.GetPage(name: '/view360_screen', page: () => Image360Screen()),
          get_package.GetPage(name: '/filter_screen', page: () => FilterScreen()),
          get_package.GetPage(name: '/create_property', page: () => CreatePropertyScreen()),
          get_package.GetPage(name: '/home_screen', page: () => HomeScreen(onDrawerChanged: (isOpen) {})),
          get_package.GetPage(name: '/forgot_password', page: () => ForgotPassword()),
          get_package.GetPage(name: '/forgot_password_code', page: () => ForgotPasswordCode()),
          get_package.GetPage(name: '/reset_password', page: () => ResetYourPassword()),
          get_package.GetPage(name: '/profile', page: () => ProfileView()),
          get_package.GetPage(name: '/contact', page: () => SelectContact()),
        ],
      ),
    );
  }
}
