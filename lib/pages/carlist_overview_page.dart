import 'package:auto_size_text/auto_size_text.dart';
import 'package:cars/common/my_colors.dart';
import 'package:cars/model/car.model.dart';
import 'package:cars/services/car_service.dart';
import 'package:cars/widget/app_drawer.dart';
import 'package:cars/widget/car_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:cars/controller/testdatabase.dart';

class CarListOverviewPage extends StatefulWidget {
  const CarListOverviewPage({super.key});

  @override
  State<CarListOverviewPage> createState() => _CarListOverviewPageState();
}

class _CarListOverviewPageState extends State<CarListOverviewPage> {
  List<Car> _cars = [];

  @override
  void initState() {
    super.initState();
    printDatabasePath();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final cars = await fetchCars();
      setState(() {
        _cars = cars;
      });
    } catch (e) {
      setState(() {
        _cars = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            toolbarHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.9,
              centerTitle: true,
              titlePadding:
                  const EdgeInsets.only(left: 50, right: 16, bottom: 16),
              title: AutoSizeText('Veja os destaques dessa semana!',
                  maxLines: 2,
                  maxFontSize: 20,
                  minFontSize: 10,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headlineLarge),
              background: Image.asset(
                'assets/images/banner.webp',
                fit: BoxFit.cover,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) => GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: MyColors.drawerTheme,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.menu,
                    size: 30,
                    color: MyColors.darkTextTheme,
                  ),
                ),
              ),
            ),
          ),
          _cars.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : CarListWidget(cars: _cars),
          _cars.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : CarListWidget(cars: _cars),
        ],
      ),
    );
  }
}
