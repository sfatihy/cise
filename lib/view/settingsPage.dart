import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/userDatabaseModel.dart';
import 'package:cise/product/appConstants.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/viewModel/profileCubit.dart';
import 'package:cise/viewModel/profileState.dart';
import 'package:cise/viewModel/settingsCubit.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/CustomModalBottomSheet.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';
import 'package:cise/widget/TextFromFieldContainer.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.settings.value),
          leading: IconButton(
            icon: IconConstants.arrowBackIcon,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          actions: const [
            Padding(
              padding: PaddingConstants.bodyRPadding,
              child: IconConstants.settingsIcon,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: PaddingConstants.bodyLTPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.personalInformation.value, style: Theme.of(context).textTheme.titleMedium,),
                  IconButton(
                    icon: IconConstants.editIcon,
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return CustomModalBottomSheet(
                            widget: BlocProvider(
                              create: (context) => ProfileCubit(),
                              child: BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                                    if (state is ProfileInitial) {
                                      context.read<ProfileCubit>().readAllData();
                                      return CustomStateInitial();
                                    }
                                    else if (state is ProfileLoading) {
                                      return CustomStateLoading();
                                    }
                                    else if (state is ProfileLoaded){
                                      return Column(
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: TextFormFieldContainer(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: state.user.userName.toString(),
                                                  border: InputBorder.none,
                                                ),
                                                controller: context.read<ProfileCubit>().usernameController,
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
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Row(
                                              children: [
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                      value: context.read<ProfileCubit>().sourceValue,
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
                                                        context.read<ProfileCubit>().changeSourceValue(newValue as String);
                                                        context.read<ProfileCubit>().readAllData();
                                                      }
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: const Icon(Icons.compare_arrows),
                                                    onPressed: () {
                                                      context.read<ProfileCubit>().changeSourceToDestination();
                                                      context.read<ProfileCubit>().readAllData();
                                                    }
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                      value: context.read<ProfileCubit>().destinationValue,
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
                                                        context.read<ProfileCubit>().changeDestinationValue(newValue as String);
                                                        context.read<ProfileCubit>().readAllData();
                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const CustomHeightSpace(),
                                          OutlinedButton.icon(
                                            icon: IconConstants.saveIcon,
                                            label: Text(LocaleKeys.saveButton.value.toString()),
                                            onPressed: () {
                                              if (_formKey.currentState!.validate()) {

                                                User user = User(
                                                    id: 1,
                                                    userName: context.read<ProfileCubit>().usernameController.text,
                                                    motherLanguage: context.read<ProfileCubit>().sourceValue,
                                                    foreignLanguage: context.read<ProfileCubit>().destinationValue
                                                );

                                                context.read<ProfileCubit>().updateUser(user);

                                                Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false);
                                              }
                                            },
                                          )
                                        ],
                                      );
                                    }
                                    else {
                                      return Text("asd");
                                    }
                                  }
                              ),
                            )
                        );
                      });
                    },
                  )
                ],
              ),
            ),
            BlocProvider(
              create: (context) => ProfileCubit(),
              child: BlocBuilder<ProfileCubit, ProfileState>(
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
                      children: [
                        Container(
                          padding: PaddingConstants.bodyLRPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.username.value),
                              Text(state.user.userName.toString()),
                            ],
                          ),
                        ),
                        Container(
                          padding: PaddingConstants.bodyLTRPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.native.value),
                              Text(AppConstants.languages[state.user.motherLanguage.toString()].toString()),
                            ],
                          ),
                        ),
                        Container(
                          padding: PaddingConstants.bodyLTRPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.learning.value),
                              Text(AppConstants.languages[state.user.foreignLanguage.toString()].toString()),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  else {
                    return CustomStateError(error: "Setting not loaded.", func: context.read<ProfileCubit>().readAllData());
                  }
                },
              ),
            ),

            Padding(
              padding: PaddingConstants.bodyLTPadding,
              child: Text(LocaleKeys.application.value, style: Theme.of(context).textTheme.titleMedium,),
            ),
            ListTile(
              title: Text("Theme", style: Theme.of(context).textTheme.bodyMedium,),
              subtitle: context.read<SettingsCubit>().darkOrLight == true ? Text(LocaleKeys.dark.value) : Text(LocaleKeys.light.value, style: TextStyle(color: Colors.black),),
              trailing: SizedBox(
                height: 100,
                width: 100,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Switch(
                    value: context.read<SettingsCubit>().darkOrLight,
                    //activeThumbImage: const AssetImage("assets/logo.png"),
                    activeColor: Theme.of(context).colorScheme.primary,
                    activeTrackColor: Colors.white,
                    //inactiveThumbImage: const AssetImage("assets/rainRight.png"),
                    inactiveThumbColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor: Theme.of(context).colorScheme.surface,
                    onChanged: (newValue) {
                      context.read<SettingsCubit>().toggleTheme();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
