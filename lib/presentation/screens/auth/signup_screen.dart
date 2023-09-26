import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../bussines_logic/app_cubit.dart';
import '../../../core/screens.dart' as screens;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();
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
      body: SingleChildScrollView(
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
                  'sign up now to see what they are tailking!',
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
                Image.asset(
                  'assets/register.png',
                  height: 40.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  child: TextFormField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    scrollPhysics: const ScrollPhysics(),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsetsDirectional.symmetric(vertical: 1.h),
                      prefixIcon: const Icon(
                        Icons.person_sharp,
                        color: Colors.deepOrange,
                      ),
                      label: const Text(
                        "User Name",
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
                        return ' name can\'t  be empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 1.h,
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
                              icon: Icon(cubit.first, color: Colors.deepOrange),
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
                            } else if (value.length < 8) {
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
                      padding: EdgeInsets.only(top: 1.h),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        child: TextFormField(
                          controller: confirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          scrollPhysics: const ScrollPhysics(),
                          obscureText: cubit.isHiddenConfirm,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.symmetric(
                                vertical: 1.2.h),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.deepOrange,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => cubit.changeSuffixConfirm(),
                              icon: Icon(cubit.firstConfirm,
                                  color: Colors.deepOrange),
                            ),
                            label: const Text(
                              "Confirm Password",
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
                            } else if (value.length < 8) {
                              return 'password cant be less than 8 characters';
                            } else if (value != password.text) {
                              return 'password cant be matched';
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
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                globalKey.currentState!.save();
                                cubit.signup(
                                    name: name.text,
                                    email: email.text,
                                    password: password.text,
                                    context: context);
                                Fluttertoast.showToast(
                                    msg: "Sing Up Successes",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0.sp);

                                Navigator.pushNamed(
                                    context, screens.loginScreen);
                              }
                            },
                            child: Text(
                              'Sign Up',
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
                      'already have  a account?',
                      style: TextStyle(),
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, screens.loginScreen),
                        child: const Text(
                          'login!',
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
      ),
    );
    ;
  }
}
