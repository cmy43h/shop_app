import 'package:flutter/foundation.dart';

class CartItems {
  final String id;
  final String title;
  int qnty;
  final double price;

  CartItems(
      {@required this.title,
      @required this.id,
      @required this.price,
      @required this.qnty});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemCount {
    var totalCount = 0;
    _items.forEach((key, value) {
      totalCount += value.qnty;
    });
    return totalCount;
  }

  double get totalAmount {
    var totalAmount = 0.0;
    _items.forEach((key, value) {
      totalAmount += (value.qnty * value.price);
    });
    return totalAmount;
  }

  double totalAmountPerItem(double price, String title) {
    var valueInfo =
        _items.values.toList().firstWhere((element) => element.title == title);
    return valueInfo.qnty * valueInfo.price;
  }

  void getQuantity(String title, bool instruction) {
    _items.forEach((key, value) {
      if (value.title == title) {
        if (instruction == true) {
          value.qnty++;
        } else if (instruction == false && value.qnty > 1) {
          value.qnty--;
        }
        notifyListeners();
      }
    });
  }

  void addItemInCart(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItems(
              title: value.title,
              id: value.id,
              price: value.price,
              qnty: value.qnty + 1));
    } else {
      _items.putIfAbsent(
          productId,
              () =>
              CartItems(
                  title: title,
                  id: DateTime.now().toString(),
                  price: price,
                  qnty: 1));
    }
    _items.forEach((key, value) {
      print(value);
    });
    notifyListeners();
  }

  void removeAll(List<String> id) {
    for (int i = 0; i < id.length; i++) {
      _items.remove(id[i]);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }
}
