import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/drawer.dart';

class ProductDetailScreen extends StatefulWidget {
  static const route = '/productDetail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _productId;
  bool _isInitiated = false;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_loadedProducts.title),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                _loadedProducts.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black12,
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      _loadedProducts.title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    child: Text(
                      '\$' + _loadedProducts.price.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
