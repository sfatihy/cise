import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/database/userDatabaseModel.dart';

abstract class AddState {
  const AddState();
}

class AddInitial extends AddState {}

class AddLoading extends AddState {}

class AddLoaded extends AddState {
  final User user;
  final List<Tag> data;
  int tag;

  AddLoaded(this.user, this.data, this.tag);
}

class AddError extends AddState {}