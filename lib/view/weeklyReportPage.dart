import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/viewModel/cardCubit.dart';
import 'package:cise/viewModel/cardState.dart';
import 'package:cise/widget/CustomCard.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeeklyReportPage extends StatelessWidget {
  const WeeklyReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.weeklyReport.value),
        leading: IconButton(
          icon: IconConstants.arrowBackIcon,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        actions: const [
          Padding(
            padding: PaddingConstants.bodyRPadding,
            child: IconConstants.weeklyReport,
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => CardCubit(),
        child: BlocBuilder<CardCubit, CardState>(
          builder: (context, state) {
            if (state is CardInitial) {
              context.read<CardCubit>().changeFilterTagId(-1);
              context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId);
              return CustomStateInitial();
            }
            else if (state is CardLoading) {
              return CustomStateLoading();
            }
            else if (state is CardsLoaded) {
              return ListView.builder(
                itemCount: state.words.length,
                itemBuilder: (context, index) {
                  if (DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(state.words[index].wordMemorizedDate ?? ""))).inDays < 7) {
                    return CustomCard(data: state.words[index]);
                  }
                }
              );
            }
            else {
              return CustomStateError(
                error: "Weekly Report Page Error",
                func: context.read<CardCubit>().getDataFromDatabase(context.read<CardCubit>().filterTagId)
              );
            }
          },
        ),
      ),
    );
  }
}
