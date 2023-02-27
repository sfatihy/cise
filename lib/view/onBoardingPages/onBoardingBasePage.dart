import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/userDatabaseModel.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/view/homePage.dart';
import 'package:cise/view/onBoardingPages/onBoardingPage1.dart';
import 'package:cise/view/onBoardingPages/onBoardingPage2.dart';
import 'package:cise/view/onBoardingPages/onBoardingPage3.dart';
import 'package:cise/viewModel/onBoardingCubit.dart';
import 'package:cise/viewModel/onBoardingState.dart';
import 'package:cise/widget/CustomSnackBar.dart';
import 'package:cise/widget/CustomStateError.dart';
import 'package:cise/widget/CustomStateInitial.dart';
import 'package:cise/widget/CustomStateLoading.dart';

class OnBoardingBasePage extends StatefulWidget {
  const OnBoardingBasePage({Key? key}) : super(key: key);

  @override
  State<OnBoardingBasePage> createState() => _OnBoardingBasePageState();
}

class _OnBoardingBasePageState extends State<OnBoardingBasePage> with SingleTickerProviderStateMixin {

  final PageController _pageController = PageController(initialPage: 0);
  late final TabController _tabController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
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
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            List pages = [OnBoardingPage1(context, formKey), OnBoardingPage2(context), OnBoardingPage3(context)];
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  itemCount: 3,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                  onPageChanged: (int value) {
                    print("Page: ${value + 1}");

                    if (_tabController.index == 0 && context.read<OnBoardingCubit>().nameController.text.length < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(text: "You need fill the blank.")
                      );
                      _pageController.jumpToPage(0);
                    }
                    else {
                      setState((){
                        _tabController.index = value;
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*GestureDetector(
                          child: Row(
                            children: const [
                              Text("Skip"), Icon(Icons.cable)
                            ],
                          ),
                          onTap: () {
                            _tabController.animateTo(2);
                            _pageController.animateToPage(2, duration: Duration(milliseconds: 2000), curve: Curves.bounceOut);
                          },
                        ),*/
                      TabPageSelector(
                        controller: _tabController,
                        color: Colors.white,
                        selectedColor: Theme.of(context).primaryColor,
                      ),
                      GestureDetector(
                        child: _tabController.index != 2 ?
                        Row(
                          children: [
                            Text("Next"), IconConstants.nextIcon
                          ],
                        )
                            :
                        Row(
                          children: [
                            Text("Done"), IconConstants.doneIcon
                          ],
                        ),
                        onTap: () {

                          if (_tabController.index == 0 && context.read<OnBoardingCubit>().nameController.text.length < 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar(text: "You need fill the blank.")
                            );
                          }
                          else if (_tabController.index == 2) {

                            print("It is done.");

                            User user = User(
                                userName: context.read<OnBoardingCubit>().nameController.text,
                                motherLanguage: context.read<OnBoardingCubit>().motherTongue,
                                foreignLanguage: context.read<OnBoardingCubit>().foreignLanguage
                            );

                            print(user);
                            context.read<OnBoardingCubit>().createUser(user);

                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

                            /*if (formKey.currentState == null) {
                              print("Current State is null");
                              _tabController.animateTo(0);
                              _pageController.animateToPage(0, duration: Duration(milliseconds: 2000), curve: Curves.bounceOut);
                            }
                            else if (formKey.currentState!.validate()) {
                              print("It is done.");

                              User user = User(
                                  userName: context.read<OnBoardingCubit>().nameController.text,
                                  motherLanguage: context.read<OnBoardingCubit>().motherTongue,
                                  foreignLanguage: context.read<OnBoardingCubit>().foreignLanguage
                              );

                              print(user);
                              context.read<OnBoardingCubit>().createUser(user);

                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                            }
                            else {
                              print("Current State is not null");
                              print("Tekrar 1 e git.");
                              _tabController.animateTo(0);
                              _pageController.animateToPage(0, duration: Duration(milliseconds: 2000), curve: Curves.bounceOut);
                            }*/
                          }
                          else{
                            print(context.read<OnBoardingCubit>().nameController.text);
                            print(context.read<OnBoardingCubit>().motherTongue);
                            print(context.read<OnBoardingCubit>().foreignLanguage);
                            _tabController.animateTo(_tabController.index + 1);
                            _pageController.nextPage(duration: const Duration(milliseconds: 2000), curve: Curves.bounceOut);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
            if (state is OnBoardingInitial) {
              context.read<OnBoardingCubit>().readData();
              return CustomStateInitial();
            }
            else if (state is OnBoardingLoading) {
              print("loading...");
              return CustomStateLoading();
            }
            else if (state is OnBoardingLoaded) {

            }
            else {
              return CustomStateError(
                error: "OnBoarding is not loaded.",
                func: context.read<OnBoardingCubit>().refresh()
              );
            }
          },
        )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
