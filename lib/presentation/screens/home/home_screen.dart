import 'package:community/bussines_logic/app_cubit.dart';
import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/core/my_cache_keys.dart';
import 'package:community/core/screens.dart' as screens;
import 'package:community/data/local/my_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();

    DataCubit.get(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, screens.searchScreen);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ))
            ],
            elevation: 0,
            backgroundColor: Colors.deepOrange,
            centerTitle: true,
            title: Text(
              'Groups',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, screens.homeScreen);
                  },
                  selectedColor: Colors.deepOrange,
                  selected: true,
                  leading: const Icon(Icons.groups),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  title: const Text(
                    'Groups',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, screens.profileScreen);
                  },
                  leading: Icon(Icons.person),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            title: const Text('Logout'),
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Create a group'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(20)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(20))),
                              onChanged: (val) {
                                DataCubit.get(context).takeGroupName(val);
                              })
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          child: const Text("CANCEL"),
                        ),
                        BlocBuilder<DataCubit, DataState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () async {
                                await DataCubit.get(context).createGroup(
                                  userName: DataCubit.get(context)
                                      .myemail['fullName'],
                                  userId: firebaseUser.uid,
                                  groupName: DataCubit.get(context).groupName,
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor),
                              child: const Text("CREATE"),
                            );
                          },
                        )
                      ],
                    );
                  });
            },
            elevation: 0,
            backgroundColor: Colors.deepOrange,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              if (state is Loadingdata)
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                );
              if (state is NoGroupJoin) {
                print('aa');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Create a group'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onChanged: (val) {
                                          DataCubit.get(context)
                                              .takeGroupName(val);
                                        })
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).primaryColor),
                                    child: const Text("CANCEL"),
                                  ),
                                  BlocBuilder<DataCubit, DataState>(
                                    builder: (context, state) {
                                      return ElevatedButton(
                                        onPressed: () async {
                                          await DataCubit.get(context)
                                              .createGroup(
                                            userName: DataCubit.get(context)
                                                .myemail['fullName'],
                                            userId: firebaseUser.uid,
                                            groupName: DataCubit.get(context)
                                                .groupName,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor),
                                        child: const Text("CREATE"),
                                      );
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.grey[700],
                        size: 75,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              }
              if (state is GroupAddedToList ||
                  state is Addeddata ||
                  state is AlreadyJoined ||
                  state is SuccessToJoin ||
                  state is GroupJoinedFull ||
                  state is DataOfGroups) {
                return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: InkWell(
                        onTap: () async {
                          MyCache.setString(
                            key: MyCacheKeys.idGroup,
                            value: DataCubit.get(context)
                                .values[index]
                                .substring(0, 13),
                          );
                          MyCache.setString(
                            key: MyCacheKeys.bringGroupData!,
                            value:
                                DataCubit.get(context).values[index].substring(
                                      14,
                                    ),
                          );
                          DataCubit.get(context).getMessage(
                            groupId: DataCubit.get(context)
                                .values[index]
                                .substring(0, 13),
                          );

                          Navigator.pushNamed(
                            context,
                            screens.chatScreen,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 8.h,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: Colors.white12),
                          child: ListTile(
                            leading: CircleAvatar(
                              maxRadius: 18.sp,
                              backgroundColor: Colors.deepOrange,
                              child: Text(DataCubit.get(context)
                                  .values[index]
                                  .substring(14, 15)),
                            ),
                            title: Text(
                              DataCubit.get(context).values[index].substring(
                                    14,
                                  ),
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            subtitle: Text(
                              'Tap For Join Conversation ',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.sp),
                            ),
                          ),

                        ),
                      ),
                    );
                  },
                  itemCount: DataCubit.get(context).values.length,
                );
              } else {
                return Container(
                  color: Colors.red,
                  child: Text('af'),
                );
              }
            },
          ),
        );
      },
    );
  }
}
