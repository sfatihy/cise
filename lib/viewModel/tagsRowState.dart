import 'package:cise/database/tagDatabaseModel.dart';

abstract class TagsRowState {
  const TagsRowState();
}

class TagsRowInitial extends TagsRowState {

}

class TagsRowLoading extends TagsRowState {

}

class TagsRowLoaded extends TagsRowState {
  final List<Tag> tags;
  final int currentTagIndex;

  TagsRowLoaded({
    required this.tags,
    required this.currentTagIndex
  });
}

class TagsError extends TagsRowState {}