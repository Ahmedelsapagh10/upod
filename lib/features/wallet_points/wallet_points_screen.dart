import 'dart:convert';

import 'package:academy_lms_app/constants.dart';
import 'package:academy_lms_app/features/chat/cubit/chat_cubit.dart';
import 'package:academy_lms_app/features/chat/cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_text.dart';

class MyWalletAndPointsScreen extends StatefulWidget {
  const MyWalletAndPointsScreen({super.key});

  @override
  State<MyWalletAndPointsScreen> createState() =>
      _MyWalletAndPointsScreenState();
}

class _MyWalletAndPointsScreenState extends State<MyWalletAndPointsScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().getMyUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        var cubit = context.read<ChatCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('My Balance'),
          ),
          body: (state is LoadingGetUserDataState ||
                  cubit.mainUserDataModel == null)
              ? Center(
                  child: CircularProgressIndicator(
                    color: kDefaultColor,
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        ClipOval(
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [kDefaultShadow],
                              border: Border.all(
                                color: kDefaultColor.withOpacity(.3),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: cubit
                                            .mainUserDataModel?.data?.phone !=
                                        null
                                    ? NetworkImage(
                                        cubit.mainUserDataModel?.data?.phone)
                                    : null,
                                backgroundColor: kDefaultColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomText(
                            text: cubit.mainUserDataModel?.data?.name ??
                                'No Name',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomText(
                          text: cubit.mainUserDataModel?.data?.email ??
                              "No Email",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          colors: kGreyLightColor,
                        ),
                        CustomText(
                          text:
                              cubit.mainUserDataModel?.data?.role ?? "No role",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          colors: kGreyLightColor,
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                          height: 113,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  color: kGreyLight2Color,
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 5.0),
                                        child: CircleAvatar(
                                            backgroundColor: kDefaultColor,
                                            child: Icon(
                                              Icons.wallet,
                                              color: kWhiteColor,
                                              size: 24,
                                            ))),
                                    Flexible(
                                        child: Text(
                                      "My Wallet",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ))
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${cubit.mainUserDataModel?.data?.wallet.toString() ?? ''} ',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                          height: 113,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  color: kGreyLight2Color,
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 5.0),
                                        child: CircleAvatar(
                                            backgroundColor: kDefaultColor,
                                            child: Icon(
                                              Icons.school_rounded,
                                              color: kWhiteColor,
                                              size: 24,
                                            ))),
                                    Flexible(
                                        child: Text(
                                      "Points",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ))
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${cubit.mainUserDataModel?.data?.points.toString() ?? ''} ',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
