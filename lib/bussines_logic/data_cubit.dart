import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/core/text_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  static DataCubit get(context) => BlocProvider.of<DataCubit>(context);
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseFirestore fireStoreGroup = FirebaseFirestore.instance;
  FirebaseFirestore fireStoreMessages = FirebaseFirestore.instance;
  Map<String, dynamic> myemail = {'fullName': ''};
  late String groupName;
  List<String> values = [];
  List<String> groupJoined = [];
  List<String> members = [];
  List<Map> searchGroups2 = [];
  List<Map> messages = [];
  String admin = '';

  takeGroupName(String v) {
    groupName = v;
    emit(ChangeGroupName());
  }

  createUser({
    required String fullName,
    required String email,
  }) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    int uniqId = DateTime.now().millisecondsSinceEpoch;
    await fireStore.collection('users').doc(firebaseUser.uid.toString()).set({
      'id': firebaseUser.uid,
      'fullName': fullName,
      'email': email,
      'group': [],
      'profilPic': "",
    }).then((value) {});
  }

  createGroup(
      {required String userName,
      required String userId,
      required String groupName}) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    int uniqId = DateTime.now().millisecondsSinceEpoch;
    await fireStoreGroup.collection('groups').doc(uniqId.toString()).set({
      'groupName': groupName,
      'groupIcon': '',
      'admin': '${userId}_${userName}',
      'members': FieldValue.arrayUnion(["${userId}_${userName}"]),
      'groupId': uniqId,
      'recentMessage': '',
      'recentMessageSender': ''
    }).then((value) {
      emit(CreatedGroup());
      fetch();
    });
    await fireStore
        .collection('users')
        .doc(firebaseUser.uid.toString())
        .update({
      'group': FieldValue.arrayUnion(["${uniqId}_${groupName}"])
    }).then((value) {});
  }

  fetch() async {
    emit(Loadingdata());
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    await fireStore
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      values.clear();

      for (String element in value['group']) {
        values.add(element);
      }
      if (values.length != 0) {
        emit(GroupAddedToList());
      } else {
        emit(NoGroupJoin());
      }
      myemail['fullName'] = value['fullName'];
      emit(Addeddata());
    });
  }

  fetchGroups({required String? id}) async {
    emit(LoadingdataGroup());
    await fireStoreGroup.collection('groups').doc(id).get().then((value) {
      admin = value['admin'];
      emit(AdminName());
      members.clear();
      for (String element in value['members']) {
        members.add(element);
      }
      emit(DataOfGroups());
    });
  }

  searchBy(String m) async {
    emit(LoadingSerach());
    return await fireStoreGroup
        .collection('groups')
        .where('groupName', isEqualTo: m)
        .get()
        .then((value) {
      searchGroups2.clear();
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in value.docs) {
        searchGroups2.add(element.data());
      }
      if (searchGroups2.length == 0) {
        emit(FailedSerach());
      } else {
        emit(SuccessSerach());
      }
    });
  }

  isUserLogged({required int groupId, required String groupName}) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    fireStore.collection('users').doc(firebaseUser.uid).get().then((value) {
      groupJoined.clear();
      for (String element in value['group']) {
        groupJoined.add(element);
      }
      emit(GroupJoinedFull());
      if (groupJoined.contains('${groupId.toString()}_${groupName}')) {
        emit(AlreadyJoined());
      } else {
        emit(NotYetJoined());
      }
    });
  }

  joinToGroup(
      {required int groupId,
      required String groupName,
      required String name}) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    await fireStore.collection('users').doc(firebaseUser.uid).update({
      'group': FieldValue.arrayUnion(["${groupId}_${groupName}"])
    });
    await fireStoreGroup.collection('groups').doc(groupId.toString()).update({
      'members': FieldValue.arrayUnion(["${firebaseUser.uid}_${name}"]),
    });
    emit(SuccessToJoin());
  }

  leaveGroup(
      {required String groupId,
      required String groupName,
      required String name}) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    await fireStore.collection('users').doc(firebaseUser.uid).update({
      'group': FieldValue.arrayRemove(["${groupId}_${groupName}"])
    });
    await fireStoreGroup.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayRemove(["${firebaseUser.uid}_${name}"]),
    });
    emit(SuccessToLeave());
  }

  sendMessage({required String groupId}) async {
    int uniqId = DateTime.now().millisecondsSinceEpoch;
    await fireStoreMessages
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .add({
      'message': messageController.text,
      'sender': myemail['fullName'],
      'time': uniqId
    }).then((value) {});
    await fireStoreGroup.collection('groups').doc(groupId).update({
      'recentMessage': messageController.text,
      'recentMessageSender': myemail['fullName'],
      'recentMessageTime': uniqId,
    });
    messageController.clear();
  }

  getMessage({required String groupId}) async {
    await fireStoreGroup
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      messages.clear();
      event.docs.forEach((element) {
        messages.add(element.data());
      });
      emit(GetMessageSuccess());
    });
  }
}
