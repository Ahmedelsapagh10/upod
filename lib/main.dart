import 'dart:io';

import 'package:academy_lms_app/features/chat/cubit/chat_cubit.dart';
import 'package:academy_lms_app/features/home/data/repo.dart';
import 'package:academy_lms_app/screens/course_details.dart';
import 'package:academy_lms_app/screens/login.dart';
import 'package:academy_lms_app/screens/splash.dart';
import 'package:academy_lms_app/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'features/chat/data/chatrepository.dart';
import 'features/chat/data/chatwebservices.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/home/data/services.dart';
import 'providers/auth.dart';
import 'providers/categories.dart';
import 'providers/courses.dart';
import 'providers/misc_provider.dart';
import 'providers/my_courses.dart';
import 'screens/account_remove_screen.dart';
import 'screens/category_details.dart';
import 'screens/course_detail.dart';
import 'screens/courses_screen.dart';
import 'screens/sub_category.dart';

void main() {
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint(
        '${rec.loggerName}>${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  runApp(MyApp());

  WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
  // });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Languages(),
        ),
        ChangeNotifierProxyProvider<Auth, Courses>(
          create: (ctx) => Courses(
            [],
            [],
          ),
          update: (ctx, auth, prevoiusCourses) => Courses(
            prevoiusCourses == null ? [] : prevoiusCourses.items,
            prevoiusCourses == null ? [] : prevoiusCourses.topItems,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, MyCourses>(
          create: (ctx) => MyCourses([], []),
          update: (ctx, auth, previousMyCourses) => MyCourses(
            previousMyCourses == null ? [] : previousMyCourses.items,
            previousMyCourses == null ? [] : previousMyCourses.sectionItems,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    ChatCubit(ChatRepository(ChatWebServices()))),
            BlocProvider(
              create: (context) => HomeCubit(HomeRepo(HomeServices())),
            ),
          ],
          child: MaterialApp(
            title: 'UPOD',
            theme: ThemeData(
              fontFamily: 'Poppins',
              visualDensity: VisualDensity.adaptivePlatformDensity,

              // colorScheme: const ColorScheme.light(primary: kWhiteColor),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            routes: {
              '/home': (ctx) => const TabsScreen(
                    pageIndex: 0,
                  ),
              '/login': (ctx) => const LoginScreen(),
              CoursesScreen.routeName: (ctx) => const CoursesScreen(),
              CategoryDetailsScreen.routeName: (ctx) =>
                  const CategoryDetailsScreen(),
              CourseDetailScreen.routeName: (ctx) => const CourseDetailScreen(),
              CourseDetailScreen1.routeName: (ctx) =>
                  const CourseDetailScreen1(),
              SubCategoryScreen.routeName: (ctx) => const SubCategoryScreen(),
              AccountRemoveScreen.routeName: (ctx) =>
                  const AccountRemoveScreen(),
            },
          ),
        ),
      ),
    );
  }
}
