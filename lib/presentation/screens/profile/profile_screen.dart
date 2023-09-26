import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:community/core/screens.dart' as screens;
import '../../../bussines_logic/app_cubit.dart';
import '../../../bussines_logic/data_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    // TODO: implement initState
    DataCubit.get(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        width: 60.w,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          children: [
            Icon(
              Icons.account_circle,
              size: 70.sp,
              color: Colors.grey,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              DataCubit.get(context).myemail['fullName'].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, screens.homeScreen);
              },
              leading: Icon(Icons.groups),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(
                'Groups',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              selectedColor: Colors.deepOrange,
              selected: true,
              onTap: () {
                Navigator.pushNamed(context, screens.profileScreen);
              },
              leading: Icon(Icons.person),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('are you sure to wnat to Logout ?'),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context).logout();
                                Navigator.pushReplacementNamed(
                                    context, screens.loginScreen);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      );
                    });
              },
              leading: Icon(Icons.logout),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 100.sp,
              color: Colors.grey,
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Full Name',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Flexible(
                  child: Text(
                    DataCubit.get(context).myemail['fullName'],
                    style: TextStyle(),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Flexible(
                  child: Text(
                    firebaseUser.email.toString(),
                    style: TextStyle(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
