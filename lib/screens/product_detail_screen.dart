import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' show CartProvider;
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const route = '/productDetail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _productId;
  bool _isInitiated = false;
  bool _isAdded = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_isInitiated) {
      _productId = ModalRoute.of(context).settings.arguments as String;
    }
    _isInitiated = true;
  }

  @override
  Widget build(BuildContext context) {
    final _loadedProducts =
        Provider.of<Products>(context, listen: false).findById(_productId);
    final _cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Container(
            color: Color(0xFF7842E5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton.icon(
                  textColor: Colors.white,
                  onPressed: () {
                    if (!_isAdded) {
                      _cartProvider.addItemInCart(_loadedProducts.id,
                          _loadedProducts.price, _loadedProducts.title);
                      _isAdded = true;
                    } else
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Center(
                                child: Text('OK'),
                              ),
                            )
                          ],
                          elevation: 5,
                          content: Container(
                            height: 30,
                            child: Center(
                              child: Text('Product is added ot your cart'),
                            ),
                          ),
                        ),
                      );
                  },
                  label: Text('Add to Cart'),
                  icon: Icon(Icons.add_shopping_cart),
                ),
                FlatButton.icon(
                  textColor: Colors.white,
                  onPressed: null,
                  label: Text('Check Out'),
                  icon: Icon(Icons.attach_money),
                )
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              /*pinned: true,*/
              floating: false,
              title: Text(_loadedProducts.title),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.darken,
                    color: Color(0xFF7842E5).withOpacity(0.2)),
                child: Image.network(
                  _loadedProducts.imageUrl,
                  fit: BoxFit.contain,
                ),
                height: 190,
                width: double.infinity,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                      spreadRadius: 2),
                ], color: Colors.white),
                child: ListTile(
                  title: Container(
                    width: 100,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      _loadedProducts.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black87, fontSize: 25),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  subtitle: Container(
                    height: 30,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'product on exciting offer',
                      style: TextStyle(
                        color: Color(0xFF7842E5),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  trailing: Container(
                    child: Chip(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      backgroundColor: Color(0xFF7842E5).withOpacity(0.2),
                      label: Text(
                        '\$' + _loadedProducts.price.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_loadedProducts.size.isNotEmpty)
              SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Card(
                      elevation: 5,
                      shadowColor: Colors.black54,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Available size :',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                              margin: EdgeInsets.all(5),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                children: _loadedProducts.size
                                    .map((e) => Container(
                                          padding: EdgeInsets.all(2),
                                          margin: EdgeInsets.all(3),
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.black54,
                                                width: 1),
                                          ),
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ))
                                    .toList(),
                              ),
                              height: 29,
                              width: double.infinity,
                            )
                          ],
                        ),
                      )),
                ),
              ),
            SliverToBoxAdapter(
              child: Container(
                height: 250,
                width: double.infinity,
                margin: EdgeInsets.all(5),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black54,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Text(
                            'Description :',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          height: 150,
                          child: Center(
                            child: Text(_loadedProducts.description),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
