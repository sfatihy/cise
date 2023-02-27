import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/viewModel/editCubit.dart';
import 'package:cise/viewModel/editState.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/TextFromFieldContainer.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.data
  }) : super(key: key);

  final data;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    final wordController = TextEditingController(text: widget.data.word!);
    final wordTranslatedController = TextEditingController(text: widget.data.wordTranslated);
    final sentenceController = TextEditingController(text: widget.data.sentence);
    final sentenceTranslatedController = TextEditingController(text: widget.data.sentenceTranslated);
    
    int choosenTag = widget.data.tagId;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: PaddingConstants.allPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //CustomCard(data: widget.data),
                TextFormFieldContainer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Word",
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 1,
                    controller: wordController,
                    validator: (value) {
                      if (value!.length < 2) {
                        return "Error";
                      }
                      else {
                        return null;
                      }
                    },
                  )
                ),
                CustomHeightSpace(),
                TextFormFieldContainer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Translated word",
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 1,
                    controller: wordTranslatedController,
                    validator: (value) {
                      if (value!.length < 2) {
                        return "Error";
                      }
                      else {
                        return null;
                      }
                    },
                  )
                ),
                CustomHeightSpace(),
                TextFormFieldContainer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Sentence",
                      border: InputBorder.none
                    ),
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 200,
                    controller: sentenceController,
                  ),
                ),
                CustomHeightSpace(),
                TextFormFieldContainer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Translated Sentence",
                      border: InputBorder.none
                    ),
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 200,
                    controller: sentenceTranslatedController,
                  ),
                ),
                CustomHeightSpace(),
                BlocProvider(
                  create: (context) => EditCubit(),
                  child: BlocBuilder<EditCubit, EditState>(
                    builder: (context, state) {
                      return OutlinedButton.icon(
                          icon: Icon(Icons.save),
                          label: Text("Save"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              Word updateWord = Word(
                                id: widget.data.id,
                                word: wordController.text,
                                wordTranslated: wordTranslatedController.text,
                                sentence: sentenceController.text,
                                sentenceTranslated: sentenceTranslatedController.text,
                                source: widget.data.source,
                                destination: widget.data.destination,
                                wordAddedDate: widget.data.wordAddedDate,
                                wordMemorizedDate: widget.data.wordMemorizedDate,
                                isMemorized: widget.data.isMemorized,
                                tagId: widget.data.tagId
                              );

                              context.read<EditCubit>().updateWord(updateWord);

                              Navigator.pop(context);
                            }
                            else {

                            }
                          }
                      );
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
