import 'package:cise/database/wordDatabaseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/viewModel/cardState.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  int filterTagId = 0;

  // READ
  Future readDataFromDatabase(int id) async {
    try {
      emit(CardLoading());
      var response = await DatabaseHelper.instance.readWord(id);
      var data = await DatabaseHelper.instance.readAllWordWithTag(id);

      emit(CardLoaded(response, data));
    }
    catch (e) {
      CardError(e.toString());
    }
  }

  Future getDataFromDatabase(int filterTagId) async {

    try {
      emit(CardLoading());

      //final response = await Future.value(["a","b"]);
      final result = await DatabaseHelper.instance.readAllWordWithTagFilter(filterTagId);
      final tags = await DatabaseHelper.instance.readAllTag();

      /*tags.forEach((element) {
        print(element.tagName);
      });*/
      tags[tags.length -1].tagName = "All words";
      //tags.removeAt();
      //tags.insert(0, Tag(id: 0,tagName: "Memorized", tagCreatedDate: "", tagColor: ""));
      //tags.insert(1, Tag(id: tags.length + 1,tagName: "Not Memorized", tagCreatedDate: "", tagColor: ""));
      tags.add(Tag(id: -1,tagName: "Memorized", tagCreatedDate: "", tagColor: ""));
      tags.add(Tag(id: -2,tagName: "Not Memorized", tagCreatedDate: "", tagColor: ""));

      /*tags.forEach((element) {
        print("${element.id} -> ${element.tagName}");
      });*/

      int tagId = 0;
      int index = 0;
      for (index ; index < tags.length ; index++) {
        //print("${index} -> ${tags[index].id} -> ${tags[index].tagName}");
        if (tags[index].id == filterTagId) {
          tagId = index;
          break;
        }
      }
      emit(CardsLoaded(result, tags, tagId));
    }
    catch (e) {
      emit(CardError(e.toString()));
    }
  }

  // DELETE
  Future deleteDataFromDatabase(int id) async {

    try {
      await DatabaseHelper.instance.deleteWord(id);
    }
    catch (e) {
      emit(CardError(e.toString()));
    }
  }

  // UPDATE
  Future update(int id, int data) async {
    await DatabaseHelper.instance.updateWordMemorized(id, data);
  }

  // CHANGE DATA
  changeFilterTagId(int value) {
    filterTagId = value;
    emit(CardInitial());
  }


}