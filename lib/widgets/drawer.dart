import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/recentScreen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: kBottomNavigationBarHeight,
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black54,
                ),
              ),
              title: Text('Shop'),
              subtitle: Text('Discover new Products'),
              onTap: () => Navigator.of(context).pushNamed('/'),
              contentPadding: EdgeInsets.all(2),
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.shopping_basket,
                  color: Colors.black54,
                ),
              ),
              title: Text('Your Order'),
              subtitle: Text('Take a look'),
              onTap: () => Navigator.of(context).pushNamed(CartScreen.route),
              contentPadding: EdgeInsets.all(2),
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.history,
                  color: Colors.black54,
                ),
              ),
              title: Text('History'),
              subtitle: Text('Items you have already explored'),
              onTap: () => Navigator.of(context).pushNamed(RecentScreen.route),
              contentPadding: EdgeInsets.all(2),
            )
          ],
        ),
      ),
    );
  }
}
