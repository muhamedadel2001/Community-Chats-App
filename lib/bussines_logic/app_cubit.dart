import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/core/screens.dart' as screens;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> signup(
      {required String email,
      required String password,
      required String name,

      required BuildContext context}) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      DataCubit.get(context).createUser(fullName: name, email: email);
      emit(AppSignUpSuccess());
      return null;
    } on FirebaseAuthException catch (error) {
      emit(AppSignUpfailed());
      return error.message;
    }
  }

  Future<String?> login(
      {required String email,
      required String password,
    }) async {
    emit(AppSignInLoading());
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        emit(AppSignInSuccess());
        return null;
      }
    } catch (error) {
      emit(AppSignInfailed());
      print(error);
    }
    return null;
  }

  Future<String?> logout() async {
    try {
      await _auth.signOut();
      emit(AppSignOutSuccess());
    } on FirebaseAuthException catch (error) {
      emit(AppSignOutfailed());
      return error.message;
    }
    return null;
  }

  bool isHidden = true;
  bool isHiddenConfirm = true;
  //bool isLogged = false;
  IconData first = Icons.visibility_off;
  IconData firstConfirm = Icons.visibility_off;
  void changeSuffix() {
    isHidden = !isHidden;
    if (isHidden) {
      first = Icons.visibility;
    } else {
      first = Icons.visibility_off;
    }

    emit(AppChangeIcon());
  }

  void changeSuffixConfirm() {
    isHiddenConfirm = !isHiddenConfirm;
    if (isHiddenConfirm) {
      firstConfirm = Icons.visibility;
    } else {
      firstConfirm = Icons.visibility_off;
    }
    emit(AppChangeIconConfirm());
  }
}
