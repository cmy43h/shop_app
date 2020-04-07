import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

import '../providers/products_provider.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String id;
  final double price;
  final int qnty;

  CartItem({this.title, this.price, this.id, this.qnty});

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<Products>(context, listen: false).items;
    final getProductInfo =
        productsProvider.firstWhere((element) => element.title == title);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Dismissible(
      onDismissed: (direction) =>
          cartProvider.removeFromCart(getProductInfo.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      child: Container(
        child: Card(
          elevation: 8,
          shadowColor: Colors.black45,
          child: Stack(
            children: <Widget>[
              Container(
                height: 116,
                width: 85,
                child: ClipRRect(
                  child: Image.network(
                    getProductInfo.imageUrl,
                    fit: BoxFit.cover,
                    color: Colors.black12,
                    colorBlendMode: BlendMode.darken,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      bottomLeft: Radius.circular(3)),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 55,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2,
                                    color: const Color(0xFF7842E5)
                                        .withOpacity(0.3))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                  onTap: () =>
                                      cartProvider.getQuantity(title, true),
                                ),
                                Container(
                                  child: Consumer<CartProvider>(
                                    builder: (_, cp, ch) => Container(
                                      width: 20,
                                      child: Text(
                                        qnty.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    size: 15,
                                  ),
                                  onTap: () =>
                                      cartProvider.getQuantity(title, false),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      trailing: Chip(
                        label: Text(
                          '\$' +
                              cartProvider
                                  .totalAmountPerItem(getProductInfo.price,
                                      getProductInfo.title)
                                  .toString(),
                        ),
                        backgroundColor:
                            const Color(0xFF7842E5).withOpacity(0.3),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.save_alt),
                          onPressed: null,
                          label: Text('To Wishlists'),
                        ),
                        FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.attach_money),
                          label: Text('Check Out'),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
