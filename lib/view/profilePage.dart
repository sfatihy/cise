import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/viewModel/profileCubit.dart';
import 'package:cise/viewModel/profileState.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileCubit>().readAllData();
            return CustomStateInitial();
          }
          else if (state is ProfileLoading) {
            return CustomStateLoading();
          }
          else if (state is ProfileLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text("Hi, ${state.user.userName}", style: Theme.of(context).textTheme.headlineLarge,)
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text("${state.user.motherLanguage} ${LocaleKeys.sign.value} ${state.user.foreignLanguage}", style: Theme.of(context).textTheme.titleMedium,)
                    ),
                  ],
                ),
                //CustomTagRow(),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.summary.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(state.summary[index].toString(), style: Theme.of(context).textTheme.headlineLarge,),
                            Text(LocaleKeys.profilePage.value[index].toString(), style: Theme.of(context).textTheme.headlineSmall,),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          else {
            return CustomStateError(
              error: "Profile is not loading.",
              func: context.read<ProfileCubit>().readAllData()
            );
          }
        },
      ),
    );
  }
}
