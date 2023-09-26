part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class CreateUserSuccess extends DataState {}
class Retrivedata extends DataState {}
class Loadingdata extends DataState {}
class Addeddata extends DataState {}
class CreatedGroup extends DataState {}
class LoadingGroups extends DataState {}
class GetSuccessGroups extends DataState {}
class GetFailedGroups extends DataState {}
class ChangeGroupName extends DataState {}
class NoGroupJoin extends DataState {}
class GroupAddedToList extends DataState {}
class LoadingdataGroup extends DataState {}
class DataOfGroups extends DataState {}
class AdminName extends DataState {}
class AddedToListSearch extends DataState {}
class LoadingSerach extends DataState {}
class SuccessSerach extends DataState {}
class FailedSerach extends DataState {}
class AlreadyJoined extends DataState {}
class NotYetJoined extends DataState {}
class GroupJoinedFull extends DataState {}
class SuccessToJoin extends DataState {}
class SuccessToLeave extends DataState {}
class GetMessageSuccess extends DataState {}
