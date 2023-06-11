import 'package:cise/product/appConstants.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/product/imageConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/CustomModalBottomSheet.dart';
import 'package:cise/widget/TextFromFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/userDatabaseModel.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/view/homePage.dart';
import 'package:cise/viewModel/onBoardingCubit.dart';
import 'package:cise/viewModel/onBoardingState.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> with SingleTickerProviderStateMixin {

  final PageController _pageController = PageController(initialPage: 0);
  late final TabController _tabController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 6,
        initialIndex: 0,
        vsync: this
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size contextSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 6,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Padding(
                padding: PaddingConstants.allSmallPadding.copyWith(bottom: contextSize.height * 0.05),
                child: Image.asset(
                  ImageConstants.mockups[index],
                  fit: BoxFit.contain,
                ),
              );
            },
            onPageChanged: (int page) {
              setState((){
                _tabController.animateTo(page, duration: const Duration(milliseconds: 1000), curve: Curves.slowMiddle);
              });
            },
          ),
          Align(
            alignment: Alignment(0,-0.9),
            child: Padding(
              padding: PaddingConstants.allPadding,
              child: TabPageSelector(
                controller: _tabController,
                color: Theme.of(context).colorScheme.primary,
                selectedColor: Theme.of(context).colorScheme.surface,
                borderStyle: BorderStyle.solid,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0,0.8),
            child: Padding(
              padding: PaddingConstants.bodyLRPadding,
              child: Text(
                LocaleKeys.onBoardingPage.value[_tabController.index].toString(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorConstants.textBlackColor),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: PaddingConstants.allSmallPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tabController.index < 4 ?
                  TextButton(
                    child: Text(
                      LocaleKeys.onBoardingSkipButton.value,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    onPressed: () {
                      _pageController.animateToPage(_tabController.length-1, duration: Duration(milliseconds: 2000), curve: Curves.fastOutSlowIn);
                    },
                  )
                  :
                  SizedBox(
                    height: 48,
                  ),
                  _tabController.index != 5 ?
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.onBoardingNextButton.value,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Icon(
                          IconConstants.nextIcon.icon,
                          color: Theme.of(context).colorScheme.surface,
                        )
                      ],
                    ),
                    onTap: () {
                      _pageController.nextPage(duration: const Duration(milliseconds: 2000), curve: Curves.fastOutSlowIn);
                    },
                  )
                  :
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.onBoardingDoneButton.value,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Icon(
                          IconConstants.doneIcon.icon,
                          color: Theme.of(context).colorScheme.surface,
                        )
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return CustomModalBottomSheet(
                                widget: BlocProvider(
                                  create: (context) => OnBoardingCubit(),
                                  child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          Form(
                                            key: formKey,
                                            child: TextFormFieldContainer(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: "username",
                                                ),
                                                controller: context.read<OnBoardingCubit>().nameController,
                                                validator: (value) {
                                                  if (value!.length <= 2) {
                                                    return "Must be at least 2 characters";
                                                  }
                                                  else{
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          CustomHeightSpace(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(LocaleKeys.onBoardingMotherLanguage.value),
                                              Text(LocaleKeys.onBoardingForeignLanguage.value)
                                            ],
                                          ),
                                          CustomHeightSpace(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  value: context.read<OnBoardingCubit>().motherTongue,
                                                  items: AppConstants.languages.map((key, value) {
                                                    return MapEntry(key, DropdownMenuItem(
                                                        value: key,
                                                        child: Text(value)
                                                    )
                                                    );
                                                  }).values.toList(),
                                                  alignment: Alignment.center,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                  dropdownColor: ColorConstants.backgroundDarkAccentColor,
                                                  onChanged: (newValue) {
                                                    context.read<OnBoardingCubit>().changeMotherTongue(newValue.toString());
                                                  },
                                                ),
                                              ),
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  value: context.read<OnBoardingCubit>().foreignLanguage,
                                                  items: AppConstants.languages.map((key, value) {
                                                    return MapEntry(key, DropdownMenuItem(
                                                        value: key,
                                                        child: Text(value)
                                                    )
                                                    );
                                                  }).values.toList(),
                                                  alignment: Alignment.center,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                  dropdownColor: ColorConstants.backgroundDarkAccentColor,
                                                  onChanged: (newValue) {
                                                    context.read<OnBoardingCubit>().changeForeignLanguage(newValue.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          CustomHeightSpace(),
                                          OutlinedButton.icon(
                                            icon: IconConstants.personIcon,
                                            label: Text(LocaleKeys.onBoardingCreateUserButton.value),
                                            onPressed: () {
                                              if (formKey.currentState!.validate()) {

                                                User user = User(
                                                  userName: context.read<OnBoardingCubit>().nameController.text,
                                                  motherLanguage: context.read<OnBoardingCubit>().motherTongue,
                                                  foreignLanguage: context.read<OnBoardingCubit>().foreignLanguage
                                                );

                                                context.read<OnBoardingCubit>().createUser(user);

                                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                                              }
                                            }
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )
                            );
                          }
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: false,
    );
  }
}
