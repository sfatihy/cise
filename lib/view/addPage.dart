import 'package:cise/widget/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:cise/product/appConstants.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/viewModel/addCubit.dart';
import 'package:cise/viewModel/addState.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/CustomModalBottomSheet.dart';
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
  final _tagFormKey = GlobalKey<FormState>();

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
            child: BlocProvider(
              create: (context) => AddCubit(),
              child: BlocBuilder<AddCubit, AddState>(
                builder: (context, state) {
                  if (state is AddInitial) {
                    context.read<AddCubit>().readData();
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
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 50,
                                    padding: PaddingConstants.bodyLPadding,
                                    child: ListView.builder(
                                      itemCount: state.data.length - 1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          // Burası chip e çevrilebilir.
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(state.data[index].tagColor ?? "0xFFFFFFFF")),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                color: state.tag == state.data[index].id ? Theme.of(context).colorScheme.primary : ColorConstants.backgroundDarkColor,
                                                width: state.tag == state.data[index].id ? 2 : 0,
                                                style: BorderStyle.solid
                                              ),
                                            ),
                                            padding: PaddingConstants.allSmallPadding,
                                            margin: index < state.data.length - 1 ? PaddingConstants.bodyRPadding : EdgeInsets.only(right: 48),
                                            child: Center(
                                              child: Text("#${state.data[index].tagName}",
                                                style: Theme.of(context).textTheme.titleMedium,
                                              )
                                            ),
                                          ),
                                          onTap: () {
                                            context.read<AddCubit>().changeTag(state.data[index].id ?? 0);
                                            context.read<AddCubit>().readData();
                                          },
                                          onDoubleTap: () {
                                            print("data");
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: FloatingActionButton.small(
                                        child: IconConstants.addIcon,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context, builder: (context) {
                                            return CustomModalBottomSheet(
                                              widget: BlocProvider(
                                                create: (context) => AddCubit(),
                                                child: BlocBuilder<AddCubit, AddState>(
                                                  builder: (context, state) {
                                                    return Column(
                                                      children: [
                                                        Form(
                                                          key: _tagFormKey,
                                                          child: TextFormFieldContainer(
                                                            child: TextFormField(
                                                              decoration: const InputDecoration(
                                                                  hintText: "Tag Name",
                                                                  border: InputBorder.none
                                                              ),
                                                              minLines: 1,
                                                              maxLines: 1,
                                                              controller: context.read<AddCubit>().tagNameController,
                                                              validator: (value) {
                                                                if (value!.length < 2) {
                                                                  return "Must be at least 2 characters";
                                                                }
                                                                else{
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const CustomHeightSpace(),
                                                        SlidePicker(
                                                          pickerColor: Theme.of(context).colorScheme.primary,
                                                          enableAlpha: false,
                                                          onColorChanged: (Color c) {
                                                            context.read<AddCubit>().changeColor(c);
                                                          },
                                                        ),
                                                        const CustomHeightSpace(),
                                                        OutlinedButton.icon(
                                                          icon: IconConstants.addIcon,
                                                          label: Text("Add Tag"),
                                                          onPressed: () async {
                                                            if (_tagFormKey.currentState!.validate()) {
                                                              Tag newTag = Tag(
                                                                  tagName: context.read<AddCubit>().tagNameController.text,
                                                                  tagCreatedDate: DateTime.now().microsecondsSinceEpoch.toString(),
                                                                  tagColor: "0x${context.read<AddCubit>().colorController.value.toRadixString(16).toUpperCase()}"
                                                              );
                                                              Tag result = await context.read<AddCubit>().createTag(newTag);
                                                              Navigator.pop(context);

                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  CustomSnackBar(text: result.tagName.toString() + " added!")
                                                              );
                                                            }
                                                            else {

                                                            }
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }).then((value) => {
                                              context.read<AddCubit>().readData()
                                          });
                                        },
                                      )),
                                ],
                              ),
                            ),
                            const CustomHeightSpace(),
                            OutlinedButton.icon(
                              icon: IconConstants.addIcon,
                              label: Text(LocaleKeys.wordAdd.value),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
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
                                    tagId: state.tag
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

                                  Word result = await context.read<AddCubit>().createRandomData();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackBar(text: result.word.toString() + " ${LocaleKeys.sign.value} " + result.wordTranslated.toString() + " added!")
                                  );
                                }
                            )
                          ],
                        ),
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
          )),
    );
  }
}
