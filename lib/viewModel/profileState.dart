import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/database/userDatabaseModel.dart';

class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<Tag> tags;
  final List summary;

  ProfileLoaded(this.user, this.tags, this.summary);
}

class ProfileError extends ProfileState {}