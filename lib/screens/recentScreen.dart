import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/products_provider.dart';
import '../widgets/drawer.dart';

class RecentScreen extends StatelessWidget {
  static const route = '/recent';

  @override
  Widget build(BuildContext context) {
    final recentItemProvider =
        Provider.of<Products>(context, listen: false).recent;
    final recentProvider = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Recents')),
      drawer: MyDrawer(),
      body: recentItemProvider.length > 0
          ? ListView.builder(
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: recentItemProvider[index],
                  child: Dismissible(
                      onDismissed: (direction) => recentProvider
                          .removeRecent(recentItemProvider[index].id),
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
                      key: ValueKey(recentItemProvider[index].id),
                      child: GestureDetector(
                        child: Container(
                          child: Card(
                            elevation: 8,
                            shadowColor: Colors.black45,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 85,
                                  width: 70,
                                  child: ClipRRect(
                                    child: Image.network(
                                      recentItemProvider[index].imageUrl,
                                      fit: BoxFit.cover,
                                      color: Colors.black12,
                                      colorBlendMode: BlendMode.darken,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 50,
                                      width: 30,
                                    ),
                                    title:
                                        Text(recentItemProvider[index].title),
                                    trailing: Chip(
                                      label: Text(
                                        '\$' +
                                            recentItemProvider[index]
                                                .price
                                                .toString(),
                                      ),
                                      backgroundColor: const Color(0xFF7842E5)
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () => Navigator.of(context).pushNamed(
                            ProductDetailScreen.route,
                            arguments: recentItemProvider[index].id),
                      )),
                );
              },
              itemCount: recentItemProvider.length,
            )
          : Center(
              child: Text(
                'No recent',
                style: TextStyle(color: Colors.black87),
              ),
            ),
    );
  }
}
