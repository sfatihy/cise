import 'package:cise/product/appConstants.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/viewModel/randomWordsCubit.dart';
import 'package:cise/viewModel/randomWordsState.dart';
import 'package:cise/viewModel/tagsRowCubit.dart';
import 'package:cise/viewModel/tagsRowState.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/CustomLanguageCircle.dart';
import 'package:cise/widget/CustomModalBottomSheet.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';
import 'package:cise/widget/CustomTagsRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomWordsPage extends StatelessWidget {
  RandomWordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RandomWordsCubit()..readAllData(),
              ),
              BlocProvider(
                create: (context) => TagsRowCubit()..setTags(),
              )
            ],
            child: BlocBuilder<RandomWordsCubit, RandomWordsState>(
              builder: (context, state) {
                if (state is RandomWordsInitial) {
                  return CustomStateInitial();
                }
                else if (state is RandomWordsLoading) {
                  return CustomStateLoading();
                }
                else if (state is RandomWordsLoaded) {
                  return Stack(
                    children: [
                      PageView.builder(
                        itemCount: context.read<RandomWordsCubit>().wordList.length,
                        controller: context.read<RandomWordsCubit>().pageController,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: CustomLanguageCircle(lang: context.read<RandomWordsCubit>().wordList[index].keys.first),
                                title: Text(context.read<RandomWordsCubit>().wordList[index].values.first),
                              ),
                              CustomHeightSpace(),
                              ListTile(
                                leading: CustomLanguageCircle(lang: context.read<RandomWordsCubit>().wordList[index].keys.last),
                                title: Text(context.read<RandomWordsCubit>().wordList[index].values.last),
                              ),
                            ],
                          );
                        },
                        onPageChanged: (int value) async {
                          await context.read<RandomWordsCubit>().changePage(value);
                        },
                        scrollDirection: Axis.vertical,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: IconConstants.arrowBackIcon,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: IconConstants.settingsIcon,
                          onPressed: () {
                            var firstContext = context;
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: firstContext,
                              builder: (firstContext) {
                                return StatefulBuilder(
                                  builder: (firstContext, setState) {
                                    return CustomModalBottomSheet(
                                      widget: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Row(
                                              children: [
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    value: context.read<RandomWordsCubit>().sourceValue,
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
                                                          context.read<RandomWordsCubit>().changeSourceValue(newValue as String);
                                                          setState(() {

                                                          });
                                                        }
                                                    ),
                                                  ),
                                                  IconButton(
                                                      icon: IconConstants.compareArrowIcon,
                                                      onPressed: () {
                                                        context.read<RandomWordsCubit>().changeSourceToDestination();
                                                        setState(() {

                                                        });
                                                      }
                                                  ),
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                        value: context.read<RandomWordsCubit>().destinationValue,
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
                                                          context.read<RandomWordsCubit>().changeDestinationValue(newValue as String);
                                                          setState(() {

                                                          });
                                                        }
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const CustomHeightSpace(),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                              }
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          icon: IconConstants.addIcon,
                          iconSize: 36,
                          onPressed: () {
                            context.read<RandomWordsCubit>().setCurrentIndexFromTagsRowCubit(context.read<TagsRowCubit>().getCurrentTagIndex);
                            context.read<RandomWordsCubit>().createWord();
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(0,-0.5),
                        child: AnimatedOpacity(
                          opacity: context.read<RandomWordsCubit>().opacity,
                          duration: Duration(milliseconds: 500),
                          child: Visibility(
                            visible: context.read<RandomWordsCubit>().visibility,
                            child: IconConstants.swipeDownIcon),
                          curve: Curves.ease,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0,0.8),
                        child: BlocBuilder<TagsRowCubit, TagsRowState>(
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
                        )
                      )
                    ],
                  );
                }
                else {
                  return CustomStateError(
                      error: "Random words are not loading.",
                      func: context.read<RandomWordsCubit>().readAllData()
                  );
                }
              },
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
