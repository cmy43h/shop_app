import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/badge.dart';
import '../widgets/drawer.dart';
import '../widgets/product_item.dart';

enum FilterOption { favorite, showAll }

class ProductOverviewScreen extends StatefulWidget {
  static const route = '/';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOption.favorite,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOption.showAll,
                )
              ],
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.favorite) {
                    _isFavorite = true;
                  } else if (selectedValue == FilterOption.showAll) {
                    _isFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
            ),
            Consumer<CartProvider>(
              builder: (_, cp, ch) => Badge(
                child: ch,
                value: cartProvider.itemCount.toString(),
                color: Colors.pink,
              ),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(CartScreen.route)),
            )
          ],
        ),
        drawer: MyDrawer(),
        body: ProductGrid(_isFavorite));
  }
}

class ProductGrid extends StatelessWidget {
  final bool _isFavorite;

  ProductGrid(this._isFavorite);

  @override
  Widget build(BuildContext context) {
    final _productData = Provider.of<Products>(context);
    final _products =
        _isFavorite ? _productData.showFavoriteItems : _productData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: _products[index],
        child: ProductItem(),
      ),
      padding: const EdgeInsets.all(10.0),
      itemCount: _products.length,
    );
  }
}
