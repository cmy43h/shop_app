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
          elevation: 5,
          shadowColor: Colors.black54,
          child: Stack(
            children: <Widget>[
              Container(
                height: 115,
                width: 90,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 27,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: 10, right: 15, bottom: 5, left: 105),
                          child: Text(
                            title,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 15, left: 105),
                          child: Row(
                            children: <Widget>[
                              Text('Qnty :'),
                              Spacer(),
                              Container(
                                height: 20,
                                width: 90,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 16,
                                      width: 28,
                                      child: RaisedButton(
                                        color: Colors
                                            .white /*const Color(0xFFE0D5F6)*/,
                                        padding: EdgeInsets.all(0),
                                        onPressed: () => cartProvider
                                            .getQuantity(title, true),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            bottomLeft: Radius.circular(60),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 2, right: 2),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                        /*border: Border.all(
                                        width: 1, color: Colors.black12)*/
                                      ),
                                      child: Consumer<CartProvider>(
                                        builder: (_, cp, ch) => Container(
                                          width: 26,
                                          height: 16,
                                          color: Colors.white,
                                          child: Text(
                                            qnty.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 16,
                                      width: 28,
                                      child: RaisedButton(
                                        color:
                                            Colors.white /*Color(0xFFFFC3C8)*/,
                                        padding: EdgeInsets.all(0),
                                        onLongPress: () => cartProvider
                                            .getQuantity(title, false, true),
                                        onPressed: () => cartProvider
                                            .getQuantity(title, false),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60),
                                            bottomRight: Radius.circular(60),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text('Price :'),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.all(0),
                                height: 33,
                                child: Chip(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  label: Text(
                                    cartProvider.totalAmountPerItem(
                                        getProductInfo.price,
                                        getProductInfo.title)['mfp'],
                                  ),
                                  backgroundColor:
                                      const Color(0xFF7842E5).withOpacity(0.3),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 80,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.stars),
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
