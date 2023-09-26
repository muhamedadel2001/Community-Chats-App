part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeIcon extends AppState {}

class AppChangeIconConfirm extends AppState {}

class AppSignUpSuccess extends AppState {}

class AppSignUpfailed extends AppState {}

class AppSignInLoading extends AppState {}

class AppSignInSuccess extends AppState {}

class AppSignInfailed extends AppState {}

class AppSignInCheckSuccess extends AppState {}

class AppSignInCheckfailed extends AppState {}

class AppSignOutSuccess extends AppState {}

class AppSignOutfailed extends AppState {}
