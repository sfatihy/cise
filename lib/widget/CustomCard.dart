import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/product/functions.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/view/editPage.dart';
import 'package:cise/viewModel/cardCubit.dart';
import 'package:cise/viewModel/cardState.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY((value < 0.5) ? (pi * value) : (pi * (1 + value) )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.15,
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  context.read<CardCubit>().deleteDataFromDatabase(widget.data.id!);
                  context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId);
                },
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).colorScheme.primary,
                icon: Icons.delete,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.15,
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {

                  if (widget.data.isMemorized! == 0) {
                    context.read<CardCubit>().update(widget.data.id!);
                    context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId);
                  }
                },
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: ColorConstants.successColor,
                icon: Icons.done_outlined,
              ),
            ],
          ),
          child: Card(
            child: ListTile(
              leading:
              value < 0.5 ?
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Text(widget.data.source.toString().toUpperCase())
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary
                      )
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Text(widget.data.destination.toString().toUpperCase()),
                  ),
                ]
              ) :
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary
                          )
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Text(widget.data.source.toString().toUpperCase()),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        padding: const EdgeInsets.all(3),
                        child: Text(widget.data.destination.toString().toUpperCase())
                    ),
                  ]
              ),
              title: value < 0.5 ? Text(widget.data.word ?? "") : Text(widget.data.wordTranslated ?? ""),
              subtitle: value < 0.5 ? Text(widget.data.sentence ?? "") : Text(widget.data.sentenceTranslated ?? ""),
              trailing: Column(
                children: [
                  const Spacer(),
                  Text(Functions.getDataNumberOfDaysPassed(widget.data.wordAddedDate ?? "")),
                ],
              ),
              onTap: () {
                setState(() {
                  if (value == 0) {
                    value = 1;
                  }
                  else {
                    value = 0;
                  }
                });
              },
              onLongPress: () {
                showDialog(context: context, builder: (context) {
                  return BlocProvider(
                    create: (context) => CardCubit(),
                    child: BlocBuilder<CardCubit, CardState>(
                      builder: (context, state) {
                        if (state is CardInitial) {
                          context.read<CardCubit>().readDataFromDatabase(widget.data.id!);
                          return CustomStateInitial();
                        }
                        else if (state is CardLoading) {
                          return CustomStateLoading();
                        }
                        else if (state is CardLoaded) {
                          return AlertDialog(
                            title: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        Text("${Functions.getFullLanguageName(state.word.source ?? "")} \u27AA ${Functions.getFullLanguageName(state.word.destination ?? "")}", style: Theme.of(context).textTheme.bodySmall,),
                                        Text("#${state.tag["tagName"] ?? ""}", style: Theme.of(context).textTheme.bodySmall,)
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(state.word.word ?? ""),
                                    subtitle: Text(state.word.sentence ?? ""),
                                  ),
                                  ListTile(
                                    title: Text(state.word.wordTranslated ?? ""),
                                    subtitle: Text(state.word.sentenceTranslated ?? ""),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        state.word.isMemorized == 0 ?
                                        Text("-", style: Theme.of(context).textTheme.bodySmall) :
                                        Text(Functions.getDataNumberOfDaysPassed(state.word.wordMemorizedDate ?? ""), style: Theme.of(context).textTheme.bodySmall,),
                                        //Text("#Unit1"),
                                        Text(Functions.getDataNumberOfDaysPassed(state.word.wordAddedDate ?? ""), style: Theme.of(context).textTheme.bodySmall),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              MaterialButton(
                                  color: ColorConstants.dangerColor,
                                  shape: const StadiumBorder(),
                                  child: Text(LocaleKeys.deleteButton.value),
                                  onPressed: () {
                                    context.read<CardCubit>().deleteDataFromDatabase(state.word.id!);
                                    Navigator.pop(context);
                                  }
                              ),
                              MaterialButton(
                                  color: ColorConstants.successColor,
                                  shape: const StadiumBorder(),
                                  child: Text(LocaleKeys.editButton.value),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(data: state.word))).then((value) => {
                                      context.read<CardCubit>().readDataFromDatabase(state.word.id!)
                                    });
                                  }
                              ),
                              MaterialButton(
                                  color: ColorConstants.infoColor,
                                  shape: const StadiumBorder(),
                                  child: Text(LocaleKeys.memorizedButton.value),
                                  onPressed: () {

                                    if (widget.data.isMemorized! == 0) {
                                      context.read<CardCubit>().update(state.word.id!);
                                      Navigator.pop(context);
                                    }
                                  }
                              ),
                            ],
                          );
                        }
                        else {
                          return CustomStateError(
                            error: "Card Error",
                            func:context.read<CardCubit>().readDataFromDatabase(widget.data.id!)
                          );
                        }
                      },
                    ),
                  );
                }).then((value) => {
                  context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId)
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
