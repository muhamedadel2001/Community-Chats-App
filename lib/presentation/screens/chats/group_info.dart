import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/core/my_cache_keys.dart';
import 'package:community/data/local/my_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:community/core/screens.dart' as screens;

class GroupInforamtion extends StatefulWidget {
  const GroupInforamtion({Key? key}) : super(key: key);

  @override
  State<GroupInforamtion> createState() => _GroupInforamtionState();
}

class _GroupInforamtionState extends State<GroupInforamtion> {
  @override
  void initState() {
    DataCubit.get(context)
        .fetchGroups(id: MyCache.getString(key: MyCacheKeys.idGroup));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Info'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              onPressed: () async{
                 await DataCubit.get(context).leaveGroup(
                    groupId: MyCache.getString(key: MyCacheKeys.idGroup),
                    groupName:
                        MyCache.getString(key: MyCacheKeys.bringGroupData),
                    name: DataCubit.get(context).myemail['fullName']);
                 Navigator.pushReplacementNamed(context, screens.homeScreen);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          return ListView.builder(
              itemBuilder: (context, index) {
                if (DataCubit.get(context).members[index] ==
                    DataCubit.get(context).admin) {
                  return Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: Colors.deepOrange[100]),
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30.sp,
                          backgroundColor: Colors.deepOrange,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Center(
                                  child: Text(
                                    MyCache.getString(
                                        key: MyCacheKeys.bringGroupData),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          'Group: ${MyCache.getString(key: MyCacheKeys.bringGroupData)}',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        subtitle: Text(
                          'Admin: ${DataCubit.get(context).admin.substring(29)} ',
                          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp)),
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30.sp,
                          backgroundColor: Colors.deepOrange,
                          child: Text(DataCubit.get(context)
                              .members[index]
                              .substring(29, 30)
                              .toUpperCase()),
                        ),
                        title: Text(DataCubit.get(context)
                            .members[index]
                            .substring(29)),
                        subtitle: Text(DataCubit.get(context)
                            .members[index]
                            .substring(0, 28)),
                      ),
                    ),
                  );
                }
              },
              itemCount: DataCubit.get(context).members.length);
        },
      ),
    );
  }
}
