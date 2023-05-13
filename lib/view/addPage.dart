import 'package:cise/viewModel/tagsRowCubit.dart';
import 'package:cise/viewModel/tagsRowState.dart';
import 'package:cise/widget/CustomSnackBar.dart';
import 'package:cise/widget/CustomTagsRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:cise/product/appConstants.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/viewModel/addCubit.dart';
import 'package:cise/viewModel/addState.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';
import 'package:cise/widget/TextFromFieldContainer.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final wordController = TextEditingController();
  final sentenceController = TextEditingController();

  @override
  void dispose() {
    wordController.dispose();
    sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.addPageTitle.value.toString()),
            leading: IconButton(
              icon: IconConstants.arrowBackIcon,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AddCubit()..readData(),
                ),
                BlocProvider(
                  create: (context) => TagsRowCubit()..setTags(),
                )
              ],
              child: BlocBuilder<AddCubit, AddState>(
                builder: (context, state) {
                  if (state is AddInitial) {
                    return CustomStateInitial();
                  }
                  else if (state is AddLoading) {
                    return CustomStateLoading();
                  }
                  else if (state is AddLoaded) {
                    return Column(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.onBackground,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: context.read<AddCubit>().sourceValue,
                                  items: AppConstants.languages.map((key, value) {
                                    return MapEntry(key,
                                      DropdownMenuItem(
                                        value: key,
                                        child: Text(value)
                                      )
                                    );
                                  }
                                  ).values.toList(),
                                  alignment: Alignment.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  dropdownColor: Theme.of(context).colorScheme.onBackground,
                                  iconEnabledColor: Theme.of(context).colorScheme.surface,
                                  onChanged: (newValue) {
                                    context.read<AddCubit>().changeSourceValue(newValue as String);
                                    context.read<AddCubit>().readData();
                                  }
                                ),
                              ),
                              IconButton(
                                icon: IconConstants.compareArrowIcon,
                                onPressed: () {
                                  context.read<AddCubit>().changeSourceToDestination();
                                  context.read<AddCubit>().readData();
                                }
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: context.read<AddCubit>().destinationValue,
                                  items: AppConstants.languages.map((key, value) {
                                    return MapEntry(key,
                                      DropdownMenuItem(
                                        value: key,
                                        child: Text(value)
                                      )
                                    );
                                  }
                                  ).values.toList(),
                                  alignment: Alignment.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  dropdownColor: Theme.of(context).colorScheme.onBackground,
                                  iconEnabledColor: Theme.of(context).colorScheme.surface,
                                  onChanged: (newValue) {
                                    context.read<AddCubit>().changeDestinationValue(newValue as String);
                                    context.read<AddCubit>().readData();
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: PaddingConstants.allPadding,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextFormFieldContainer(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "word",
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Theme.of(context).colorScheme.error,
                                    minLines: 1,
                                    maxLines: 1,
                                    controller: wordController,
                                    validator: (value) {
                                      if (value!.length < 2) {
                                        return "Lütfen en az 2 karakter giriniz.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                const CustomHeightSpace(),
                                TextFormFieldContainer(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "sentence",
                                      border: InputBorder.none
                                    ),
                                    cursorColor: Theme.of(context).colorScheme.error,
                                    minLines: 3,
                                    maxLines: 5,
                                    maxLength: 200,
                                    controller: sentenceController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<TagsRowCubit, TagsRowState>(
                          builder: (context, state) {
                            if (state is TagsRowInitial) {
                              return CustomStateInitial();
                            }
                            else if (state is TagsRowLoading) {
                              return CustomStateLoading();
                            }
                            else if (state is TagsRowLoaded) {
                              return CustomTagsRow(
                                tags: state.tags,
                                currentTag: state.currentTagIndex,
                                contextTagsRow: context,
                              );
                            }
                            else {
                              return CustomStateError(
                                error: "Custom Tags Row Error",
                                func: context.read<TagsRowCubit>().setTags()
                              );
                            }
                          },
                        ),
                        const CustomHeightSpace(),
                        OutlinedButton.icon(
                          icon: IconConstants.addIcon,
                          label: Text(LocaleKeys.wordAdd.value),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<AddCubit>().setCurrentIndexFromTagsRowCubit(context.read<TagsRowCubit>().getCurrentTagIndex);

                              Word newWord = Word(
                                word: wordController.text,
                                wordTranslated: "",
                                sentence: sentenceController.text,
                                sentenceTranslated: "",
                                source: context.read<AddCubit>().sourceValue,
                                destination: context.read<AddCubit>().destinationValue,
                                wordAddedDate: DateTime.now().microsecondsSinceEpoch.toString(),
                                wordMemorizedDate: "",
                                isMemorized: 0,
                                tagId: context.read<AddCubit>().currentTagIndex
                              );

                              //print(newWord.toJson());

                              Word result = await context.read<AddCubit>().createData(newWord);

                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar(text: result.word.toString() + " ${LocaleKeys.sign.value} " + result.wordTranslated.toString() + " added!")
                              );
                            }
                            else {

                            }
                          }
                        ),
                        const CustomHeightSpace(),
                        OutlinedButton.icon(
                          icon: IconConstants.randomIcon,
                          label: Text(LocaleKeys.randomWordAdd.value),
                          onPressed: () async {
                            context.read<AddCubit>().setCurrentIndexFromTagsRowCubit(context.read<TagsRowCubit>().getCurrentTagIndex);

                            Word result = await context.read<AddCubit>().createRandomData();

                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar(text: result.word.toString() + " ${LocaleKeys.sign.value} " + result.wordTranslated.toString() + " added!")
                            );
                          }
                        )
                      ],
                    );
                  }
                  else {
                    return CustomStateError(
                      error: "Add Page Error!",
                      func: context.read<AddCubit>().readData()
                    );
                  }
                },
              ),
            ),
          )
      ),
    );
  }
}
