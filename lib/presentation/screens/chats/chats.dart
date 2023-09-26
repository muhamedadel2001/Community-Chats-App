import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/core/my_cache_keys.dart';
import 'package:community/core/text_constants.dart';
import 'package:community/data/local/my_cache.dart';
import 'package:flutter/material.dart';
import 'package:community/core/screens.dart' as screens;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Chats extends StatefulWidget {
  const Chats({
    Key? key,
  }) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    DataCubit.get(context)
        .getMessage(groupId: MyCache.getString(key: MyCacheKeys.idGroup));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, screens.homeScreen);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text(MyCache.getString(key: MyCacheKeys.bringGroupData)!),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, screens.chatSInfoScreen);
                  },
                  icon: Icon(Icons.info_outline))
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<DataCubit, DataState>(
                  builder: (context, state) {
                    if (DataCubit.get(context).messages.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                           shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                  left: DataCubit.get(context)
                                              .myemail['fullName'] ==
                                          DataCubit.get(context).messages[DataCubit.get(context).messages.length-1-index]
                                              ['sender']
                                      ? 0
                                      : 24,
                                  right: DataCubit.get(context)
                                              .myemail['fullName'] ==
                                          DataCubit.get(context).messages[DataCubit.get(context).messages.length-1-index]
                                              ['sender']
                                      ? 24
                                      : 0),
                              alignment:
                                  DataCubit.get(context).myemail['fullName'] ==
                                          DataCubit.get(context).messages[DataCubit.get(context).messages.length-1-index]
                                              ['sender']
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Container(
                                  margin: DataCubit.get(context).myemail['fullName'] ==
                                          DataCubit.get(context).messages[DataCubit.get(context).messages.length-1-index]
                                              ['sender']
                                      ? const EdgeInsets.only(left: 30)
                                      : const EdgeInsets.only(left: 30),
                                  padding: EdgeInsets.only(
                                      top: 17, bottom: 17, right: 20, left: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: DataCubit.get(context)
                                                  .myemail['fullName'] ==
                                              DataCubit.get(context)
                                                  .messages[DataCubit.get(context).messages.length-1-index]['sender']
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                      color: DataCubit.get(context)
                                                  .myemail['fullName'] ==
                                              DataCubit.get(context)
                                                  .messages[DataCubit.get(context).messages.length-1-index]['sender']
                                          ? Colors.deepOrange[400]
                                          : Colors.grey[700]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DataCubit.get(context).messages[DataCubit.get(context).messages.length-1-index]
                                            ['sender'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: -0.5),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                          DataCubit.get(context).messages[DataCubit.get(context).messages.length-1-index]
                                              ['message'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15.sp))
                                    ],
                                  )),
                            );
                          },
                          itemCount: DataCubit.get(context).messages.length,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                Container(
                  color: Colors.white,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    color: Colors.grey[500],
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Send Message',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () async {
                            if (messageController.text.isNotEmpty) {
                             await DataCubit.get(context).sendMessage(
                                  groupId: MyCache.getString(
                                      key: MyCacheKeys.idGroup));

                            }
                            setState(() { DataCubit.get(context).getMessage(
                                groupId: MyCache.getString(
                                    key: MyCacheKeys.idGroup));

                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
