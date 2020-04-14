import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product_Provider.dart';
import '../providers/products_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final individualProduct = Provider.of<Product>(context, listen: false);
    final provider = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    bool _isAdded = false;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(width: 2.0, color: const Color(0xFF7842E5))),
      child: GridTile(
        child: ClipRRect(
          child: GestureDetector(
              child: Image.network(
                individualProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.route,
                    arguments: individualProduct.id);
                provider.addRecent(individualProduct.id);
              }),
          borderRadius: BorderRadius.circular(12),
        ),
        footer: ClipRRect(
          child: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.7),
            leading: Consumer<Product>(
                builder: (context, individualProduct, child) => IconButton(
                    icon: individualProduct.isFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    onPressed: () => individualProduct.toggleFavorite())),
            trailing: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (!_isAdded) {
                    cart.addItemInCart(individualProduct.id,
                        individualProduct.price, individualProduct.title);
                    _isAdded = true;
                  } else
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Container(
                        child: Center(
                          child: Text(
                            'Product is Added in the Cart',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: 60,
                        width: double.infinity,
                      ),
                      elevation: 2,
                      backgroundColor: Color(0xFFF2EFF8),
                      duration: Duration(seconds: 3),
                    ));
                }),
            title: Text(
              individualProduct.title,
              textAlign: TextAlign.center,
            ),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
