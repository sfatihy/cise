import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/viewModel/cardCubit.dart';
import 'package:cise/viewModel/cardState.dart';
import 'package:cise/widget/CustomCard.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(),
      child: BlocConsumer<CardCubit, CardState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CardInitial) {
            context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId);
            return CustomStateInitial();
          }
          else if (state is CardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is CardsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(state.tags[state.tags.length - context.read<CardCubit>().filterTagId -3].tagName.toString()),
                        onDeleted: () {
                          context.read<CardCubit>().changeFilterTagId(0);
                        },
                      ),
                      PopupMenuButton(
                        icon: const Icon(Icons.import_export),
                        itemBuilder: (context) => state.tags.map((item) => PopupMenuItem(
                          height: 32,
                          value: item.id,
                          child: Text(item.tagName ?? "")
                        )).toList(),
                        onSelected: (int value) {
                          //print(value);
                          context.read<CardCubit>().changeFilterTagId(value);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId);
                    },
                    child: ListView.builder(
                      itemCount: state.words.length,
                      itemBuilder: (context, index) {
                        return CustomCard(data: state.words[index]);
                      }
                    ),
                  )
                )
              ],
            );
          }
          else if (state is CardError) {
            return CustomStateError(error: state.errorType, func: context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId));
          }
          else {
            return Center(
              child: Text("asd"),
            );
          }
        },
      ),
    );
  }
}
