import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/core/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/text_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(
              color: Colors.white,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, homeScreen);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Stack(alignment: AlignmentDirectional.centerEnd, children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    hintText: 'Search',
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                  onPressed: () async {
                    await DataCubit.get(context)
                        .searchBy(searchController.text);

                    if (DataCubit.get(context).searchGroups2.isNotEmpty) {
                      await DataCubit.get(context).isUserLogged(
                          groupId: DataCubit.get(context).searchGroups2[0]
                              ['groupId'],
                          groupName: DataCubit.get(context).searchGroups2[0]
                              ['groupName']);
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ]),
          ),
          Expanded(
            child: BlocBuilder<DataCubit, DataState>(
              builder: (context, state) {
                print(DataCubit.get(context).searchGroups2.length);
                if (state is SuccessSerach ||
                    state is AlreadyJoined ||
                    state is GroupJoinedFull ||
                    state is NotYetJoined ||
                    state is SuccessToJoin) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: DataCubit.get(context).searchGroups2.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BlocBuilder<DataCubit, DataState>(
                          builder: (context, state) {
                            print('aaa');
                            return ListTile(
                                leading: CircleAvatar(
                                  maxRadius: 20.sp,
                                  backgroundColor: Colors.deepOrange,
                                  child: Center(
                                    child: Text(
                                      DataCubit.get(context)
                                          .searchGroups2[index]['groupName']
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  DataCubit.get(context).searchGroups2[index]
                                      ['groupName'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    'admin: ${DataCubit.get(context).searchGroups2[index]['admin'].toString().substring(29)}'),
                                trailing: BlocBuilder<DataCubit, DataState>(
                                  builder: (context, state) {
                                    return Visibility(
                                      visible: state is AlreadyJoined,
                                      child: Container(
                                        width: 18.w,
                                        height: 3.5.h,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(5.sp)),
                                        child: Center(
                                          child: Text(
                                            'Joined',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      replacement: InkWell(
                                        onTap: () {
                                          setState(() {});
                                          DataCubit.get(context).joinToGroup(
                                            groupId: DataCubit.get(context)
                                                .searchGroups2[0]['groupId'],
                                            groupName: DataCubit.get(context)
                                                .searchGroups2[0]['groupName'],
                                            name: DataCubit.get(context)
                                                .myemail['fullName'],
                                          );
                                        },
                                        child: Container(
                                          width: 18.w,
                                          height: 3.5.h,
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius:
                                                  BorderRadius.circular(5.sp)),
                                          child: Center(
                                            child: Text(
                                              'Join',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ));
                          },
                        );
                      });
                } else {
                  if (state is LoadingSerach) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    );
                  }
                  if (state is FailedSerach) {
                    return Center(
                        child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Text(
                        'No Results\nPlease cheek Group Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ));
                  } else {
                    return Container();
                  }
                }
                ;
              },
            ),
          )
        ],
      ),
    );
  }
}
