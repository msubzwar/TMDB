part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoggedin extends UserState {}

class UserErrorLoggingIn extends UserState {}
