import 'package:cars/model/car.model.dart';

class FavoriteModel {
  final List<Car> favoriteCars = [];

  void addFavoriteCar(Car car) {
    favoriteCars.add(car);
  }

  void removeFavoriteCar(Car car) {
    favoriteCars.remove(car);
  }

  bool isFavorite(Car car) {
    return favoriteCars.contains(car);
  }

  List<Car> getFavoriteCars() {
    return favoriteCars;
  }

  void clearFavorites() {
    favoriteCars.clear();
  }

  int getFavoriteCount() {
    return favoriteCars.length;
  }  
}