// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:academy_lms_app/features/chat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../features/wallet_points/wallet_points_screen.dart';
import '../providers/auth.dart';
import '../widgets/account_list_tile.dart';
import '../widgets/custom_text.dart';
import 'account_remove_screen.dart';
import 'edit_profile.dart';
import 'my_wishlist.dart';
import 'update_password.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isLoading = false;
  bool _dataUpdated = false;
  SharedPreferences? sharedPreferences;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    sharedPreferences = await SharedPreferences.getInstance();
    var userDetails = sharedPreferences!.getString("user");

    if (userDetails != null) {
      try {
        setState(() {
          user = jsonDecode(userDetails);
        });
      } catch (e) {
        print('Error decoding user details: $e');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dataUpdated) {
      getData();
      _dataUpdated = false; // Reset the flag
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: kBackGroundColor,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: kDefaultColor),
                )
              : user == null
                  ? const Center(child: Text('No user data available'))
                  : Column(
                      children: [
                        const SizedBox(height: 25),
                        ClipOval(
                          child: InkWell(
                            onTap: () {
                              getData();
                            },
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
                                  backgroundImage: user?['photo'] != null
                                      ? NetworkImage(user!['photo'])
                                      : null,
                                  backgroundColor: kDefaultColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomText(
                            text: user?['name'] ?? 'No Name',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomText(
                          text: user!['phone'] ?? "No Phone number",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          colors: kGreyLightColor,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'Edit Profile',
                                icon: 'assets/icons/profile.svg',
                                actionType: 'edit',
                              ),
                              onTap: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditPrfileScreen(),
                                    ));

                                if (result == true) {
                                  setState(() {
                                    _dataUpdated = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'Chat',
                                isChat: true,
                                icon: 'assets/icons/profile.svg',
                                actionType: 'edit',
                              ),
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainRoomsScreen(),
                                    ));
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'My Balance',
                                icon: 'assets/icons/my_balance.svg',
                                actionType: 'edit',
                              ),
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MyWalletAndPointsScreen(),
                                    ));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            thickness: 1,
                            color: kGreyLightColor.withOpacity(0.3),
                            height: 5,
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'My Wishlists',
                                icon: 'assets/icons/wishlist.svg',
                                actionType: 'wishlists',
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MyWishlistScreen(),
                                    ));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            thickness: 1,
                            color: kGreyLightColor.withOpacity(0.3),
                            height: 5,
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'Change Password',
                                icon: 'assets/icons/key.svg',
                                actionType: 'change_password',
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdatePasswordScreen(),
                                    ));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            thickness: 1,
                            color: kGreyLightColor.withOpacity(0.3),
                            height: 5,
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'Delete Your Account',
                                icon: 'assets/icons/profile.svg',
                                actionType: 'account_delete',
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AccountRemoveScreen.routeName);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            thickness: 1,
                            color: kGreyLightColor.withOpacity(0.3),
                            height: 5,
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              child: const AccountListTile(
                                titleText: 'Log Out',
                                icon: 'assets/icons/logout.svg',
                                actionType: 'logout',
                              ),
                              onTap: () {
                                Provider.of<Auth>(context, listen: false)
                                    .logout()
                                    .then((_) =>
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '/home', (r) => false));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
