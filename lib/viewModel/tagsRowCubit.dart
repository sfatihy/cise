import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/viewModel/tagsRowState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsRowCubit extends Cubit<TagsRowState>{
  TagsRowCubit() : super(TagsRowInitial());

  List<String> _tags = [];
  int _currentTagIndex = 0;

  Color colorController = ColorConstants.primaryColor;
  final updateTagFormKey = GlobalKey<FormState>();
  final tagFormKey = GlobalKey<FormState>();
  final newTagNameController = TextEditingController();
  final tagNameController = TextEditingController();

  List<String> get getTags => _tags;
  int get getCurrentTagIndex => _currentTagIndex;

  setTags() async {
    try {
      var allTag = await DatabaseHelper.instance.readAllTag();
      emit(TagsRowLoaded(tags: allTag, currentTagIndex: _currentTagIndex));
    }
    catch (e) {
      print(e);
    }
  }

  Future createTag(Tag tag) async {
    try {
      Tag result = await DatabaseHelper.instance.createTag(tag);

      return result;
    }
    catch (e) {
      print(e);
    }

  }

  // UPDATE
  updateTag(Tag tag) async {
    try {
      Tag result = await DatabaseHelper.instance.updateTag(tag);

      return result;
    }
    catch (e) {
      print(e);
    }
  }

  // DELETE
  deleteTag(int id) async {
    try {
      await DatabaseHelper.instance.deleteTag(id);
    }
    catch (e) {
      print(e);
    }
  }

  changeCurrentTagIndex (int index) {

    if (_currentTagIndex == index) {
      _currentTagIndex = 0;
    }
    else {
      _currentTagIndex = index;
    }
  }

  changeColor(Color c) {
    colorController = c;
    //print(colorController);
  }

}