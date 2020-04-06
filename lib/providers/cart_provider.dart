import 'package:flutter/foundation.dart';

class CartItems {
  final String id;
  final String title;
  final int qnty;
  final double price;

  CartItems(
      {@required this.title,
      @required this.id,
      @required this.price,
      @required this.qnty});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItems> _items;

  Map<String, CartItems> get items {
    return {..._items};
  }

  void sddItemInCart(String productId, double price, String title) {
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
          () => CartItems(
              title: title,
              id: DateTime.now().toString(),
              price: price,
              qnty: null));
    }
  }
}
