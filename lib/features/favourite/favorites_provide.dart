import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  // List to store favorite items
  final List<Map<String, String>> _favorites = [];

  // Method to add a favorite
  void addFavorite(Map<String, String> salon) {
    _favorites.add(salon);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to remove a favorite
  void removeFavorite(Map<String, String> salon) {
    _favorites.removeWhere((item) =>
        item['title'] == salon['title'] &&
        item['subtitle'] == salon['subtitle']);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to check if an item is already a favorite
  bool isFavorite(Map<String, String> salon) {
    return _favorites.any((item) =>
        item['title'] == salon['title'] &&
        item['subtitle'] == salon['subtitle']);
  }

  // Getter to return all favorite items
  List<Map<String, String>> get favoriteShops => _favorites;
}
