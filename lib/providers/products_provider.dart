import 'package:flutter/material.dart';

import 'product_Provider.dart';

class Products with ChangeNotifier {
  List<Product> _recent = [];
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        size: ['S', 'M', 'L', 'XL']),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        size: ['S', 'M', 'L', 'XL']),
    Product(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 19.99,
        imageUrl:
            'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        size: [null]),
    Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
        size: [null]),
    Product(
        id: 'p5',
        title: 'Wooden Shoe',
        description:
            'Wooden shoes, made from willow wood. Brand: Skinwood. Colour wood.',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/89/Wooden_Shoes-willow-plain_wood.jpg',
        price: 30,
        size: [7, 8, 9, 10, 11]),
    Product(
        id: 'p6',
        title: 'pocket watch',
        description:
            ' Longines manual winding pocket watch, model 4 Grand Prix, silver casing, manufactured approx. 1900. Rear view, wear marks, clockwork visible',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Longines_4_Grand_Prix_pocket_watch_-_clockwork_visible_-_enhanced_resolution_DSF3402-PSMS.jpg/600px-Longines_4_Grand_Prix_pocket_watch_-_clockwork_visible_-_enhanced_resolution_DSF3402-PSMS.jpg',
        price: 200,
        size: null),
    Product(
        id: 'p7',
        title: 'Cantilever chair',
        description: 'Cantilever chair',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/0/07/Breuer_chair_2008_2.jpg',
        price: 50,
        size: null),
    Product(
        id: 'p8',
        title: 'Stool Thebes',
        description:
            'Stool Thebes from 1884, manufactured by Liberty & Co Ltd., London, Great Britain Exhibition in the Pinakothek der Moderne, München',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Liberty_-_Stool_Thebes_-_1884.jpg/631px-Liberty_-_Stool_Thebes_-_1884.jpg',
        price: 250,
        size: null),
    Product(
        id: 'p9',
        title: 'Hat',
        description: 'Australian Swagman',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Australian_Swagman.jpg/800px-Australian_Swagman.jpg',
        price: 40,
        size: null),
    Product(
        id: 'p10',
        title: 'Gloves',
        description: 'Laboratory gloves for cryoprotection',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Cryo_protecting_gloves.jpg/800px-Cryo_protecting_gloves.jpg',
        price: 20,
        size: null),
    Product(
        id: 'p11',
        title: 'Monitor',
        description: 'EIZO Foris FG2421 VA technology computer gaming monitor',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/EIZO_Foris_FG2421_VGA_computer_monitor_displaying_test_pattern.png/800px-EIZO_Foris_FG2421_VGA_computer_monitor_displaying_test_pattern.png',
        price: 100,
        size: null),
    Product(
        id: 'p12',
        title: 'Keyboard',
        description: 'Apple Keyboard... :V',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Apple_Keyboard_II.jpg/750px-Apple_Keyboard_II.jpg',
        price: 50,
        size: null)
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get recent {
    return [..._recent.reversed];
  }

  void addRecent(String id) {
    _recent.add(items.firstWhere((element) => element.id == id));
    print('addRecent  initiated');
    notifyListeners();
  }

  List<Product> get showFavoriteItems {
    return items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  void addProduct() {
//    _items.add(value);
    notifyListeners();
  }
}
