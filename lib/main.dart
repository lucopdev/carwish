import 'package:cars/common/app_routes.dart';
import 'package:cars/common/my_colors.dart';
import 'package:cars/common/task_manager.dart';
import 'package:cars/pages/about_us_page.dart';
import 'package:cars/pages/car_detail_page.dart';
import 'package:cars/pages/carlist_overview_page.dart';
import 'package:cars/pages/dev_control_page.dart';
import 'package:cars/pages/page_not_found.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  schedulePeriodicTask();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarWish',
      theme: ThemeData(
        primaryColor: MyColors.drawerTheme,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            size: 24,
          ),
          backgroundColor: MyColors.darkTextTheme,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: MyColors.textTheme,
            fontFamily: 'Anton',
            fontSize: 22,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(MyColors.darkTextTheme),
            backgroundColor: MaterialStatePropertyAll(MyColors.drawerTheme),
          ),
        ),
        colorScheme: ColorScheme(
          primary: MyColors.darkTextTheme,
          secondary: MyColors.darkTextTheme,
          surface: MyColors.textTheme,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: MyColors.darkTextTheme,
          onBackground: Colors.black,
          onError: MyColors.darkTextTheme,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            backgroundColor: MyColors.darkTextTheme,
            letterSpacing: 1.0,
            wordSpacing: 2,
            color: MyColors.textTheme,
            fontFamily: 'Anton',
            fontSize: 22,
          ),
          headlineMedium: TextStyle(
            color: MyColors.darkTextTheme,
            fontFamily: 'Anton',
            fontSize: 22,
          ),
          headlineSmall: TextStyle(
            color: MyColors.darkTextTheme,
            fontFamily: 'Lato',
            fontSize: 18,
          ),
        ),
      ),
      home: const CarListOverviewPage(),
      routes: {
        AppRoutes.HOME: (ctx) => const CarListOverviewPage(),
        AppRoutes.CAR_DETAIL: (ctx) => const CarDetailPage(),
        AppRoutes.ABOUT: (ctx) => const AboutUsPage(),
        AppRoutes.DEV_AREA: (ctx) => const DevControlPage(),
      },
      onUnknownRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) => const PageNotFound(),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
