import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' show CartProvider;
import '../widgets/cart_items.dart';
import '../widgets/my_dialogue.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Color(0xFF7842E5).withOpacity(0.2),
              child: ListTile(
                title: Text('Yours Cart'),
                subtitle: Text(
                    'You have ${cartProvider.items.length} items in your cart'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => CartItem(
                  title: cartProvider.items.values.toList()[index].title,
                  id: cartProvider.items.values.toList()[index].id,
                  price: cartProvider.items.values.toList()[index].price,
                  qnty: cartProvider.items.values.toList()[index].qnty,
                ),
                itemCount: cartProvider.items.length,
                padding: EdgeInsets.all(10),
              ),
            ),
            Container(
              height: 65,
              decoration: BoxDecoration(color: Color(0xFF7842E5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Text('Remove All?'),
                                content: Text(
                                    'This will remove all the items in your cart'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('No')),
                                  FlatButton(
                                      onPressed: () {
                                        cartProvider.removeAll(
                                            cartProvider.items.keys.toList());
                                        Navigator.pop(context);
                                      },
                                      child: Text('Yes'))
                                ],
                              )),
                      child: Text('Remove All',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () => showDialog(
                          context: context, builder: (context) => MyDialogue()),
                      child: Text(
                        'Check Out All',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
