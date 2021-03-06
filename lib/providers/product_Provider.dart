import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String title;
  final String id;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  final List<dynamic> size;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false,
      @required this.size});

  void toggleFavorite() {
    isFavorite = !isFavorite;

    notifyListeners();
  }
}
