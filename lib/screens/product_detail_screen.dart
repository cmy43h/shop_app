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
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 160,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  _loadedProducts.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black38,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            )
          ];
        },
        body: Center(
          child: Text('some texts'),
        ),
      ),
    );
  }
}
