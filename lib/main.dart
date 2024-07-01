import 'package:cars/common/app_routes.dart';
import 'package:cars/common/my_colors.dart';
import 'package:cars/common/task_manager.dart';
import 'package:cars/model/car.model.dart';
import 'package:cars/pages/about_us_page.dart';
import 'package:cars/pages/car_detail_page.dart';
import 'package:cars/pages/carlist_overview_page.dart';
import 'package:cars/pages/dev_control_page.dart';
import 'package:cars/pages/page_not_found.dart';
import 'package:cars/services/car.service.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  schedulePeriodicTask();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Car> _cars = [];

  @override
  void initState() {
    super.initState();
    schedulePeriodicTask();
    getCars();
  }

  void getCars() async {
    try {
      var cars = await fetchCars();
      setState(() {
        _cars = cars;
      });
    } catch (e) {
      setState(() {
        _cars = [];
      });
      print('Error: $e');
    }
  }

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
      home: CarListOverviewPage(cars: _cars),
      routes: {
        AppRoutes.HOME: (ctx) => CarListOverviewPage(cars: _cars),
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
