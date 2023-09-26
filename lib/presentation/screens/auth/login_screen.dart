import 'package:community/bussines_logic/app_cubit.dart';
import 'package:community/core/my_cache_keys.dart';
import 'package:community/core/screens.dart' as screens;
import 'package:community/data/local/my_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/text_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> globalKey = GlobalKey();
  late AppCubit cubit;

  @override
  void initState() {
    cubit = AppCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is AppSignInSuccess) {
          Navigator.pushNamed(context, screens.homeScreen);
        }
      }, builder: (context, state) {
        if (state is AppSignInLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Center(
              child: Form(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Community',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'login now to see what they are tailking!',
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                    Image.asset(
                      'assets/login.png',
                      height: 40.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.name,
                        scrollPhysics: const ScrollPhysics(),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsetsDirectional.symmetric(vertical: 1.h),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.deepOrange,
                          ),
                          label: const Text(
                            "Email",
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.deepOrange,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 0.9.sp,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 0.9.sp,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email name can\'t  be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            child: TextFormField(
                              controller: password,
                              keyboardType: TextInputType.visiblePassword,
                              scrollPhysics: const ScrollPhysics(),
                              obscureText: cubit.isHidden,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.symmetric(
                                    vertical: 1.2.h),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepOrange,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => cubit.changeSuffix(),
                                  icon: Icon(cubit.first,
                                      color: Colors.deepOrange),
                                ),
                                label: const Text(
                                  "Password",
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.deepOrange,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange,
                                    width: 0.9.sp,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange,
                                    width: 0.9.sp,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password  can\'t  be empty';
                                } else if (value!.length < 8) {
                                  return 'password cant be less than 8 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(top: 2.8.h),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  color: Colors.deepOrange),
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              child: MaterialButton(
                                onPressed: () => cubit.login(
                                  email: email.text,
                                  password: password.text,
                                ),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'dont have  a account?',
                          style: TextStyle(),
                        ),
                        TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, screens.signUpScreen),
                            child: const Text(
                              'SignUp!',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.deepOrange),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
