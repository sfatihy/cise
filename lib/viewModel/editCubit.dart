import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:cise/viewModel/editState.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitial());

  Future updateWord(Word word) async {
    await DatabaseHelper.instance.updateWord(word);
  }
}