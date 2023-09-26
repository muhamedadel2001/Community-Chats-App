

import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/presentation/screens/auth/login_screen.dart';
import 'package:community/presentation/screens/auth/signup_screen.dart';
import 'package:community/presentation/screens/chats/chats.dart';
import 'package:community/presentation/screens/chats/group_info.dart';
import 'package:community/presentation/screens/profile/profile_screen.dart';
import 'package:community/presentation/screens/splash/Splash_screen.dart';
import 'package:flutter/material.dart';

import '../../core/screens.dart' as screens;
import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    startScreen = const SplashScreen();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case screens.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case screens.homeScreen:
        return MaterialPageRoute(builder: (_) => const Home());
      case screens.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case screens.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case screens.chatScreen:
       return MaterialPageRoute(builder: (_) =>  Chats());
      case screens.chatSInfoScreen:
        return MaterialPageRoute(builder: (_) =>  GroupInforamtion());
      case screens.searchScreen:
        return MaterialPageRoute(builder: (_) =>  SearchScreen());
    }
    return null;
  }
}
