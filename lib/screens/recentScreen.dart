import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/products_provider.dart';
import '../widgets/drawer.dart';

class RecentScreen extends StatelessWidget {
  static const route = '/recent';

  @override
  Widget build(BuildContext context) {
    final recentProvider = Provider.of<Products>(context, listen: false).recent;

    return Scaffold(
      appBar: AppBar(title: Text('Recents')),
      drawer: MyDrawer(),
      body: recentProvider.length > 0
          ? ListView.builder(
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: recentProvider[index],
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.0, color: const Color(0xFF7842E5)),
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF2EFF8),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      onTap: () => Navigator.of(context).pushNamed(
                          ProductDetailScreen.route,
                          arguments: recentProvider[index].id),
                      leading: Image.network(
                        recentProvider[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        recentProvider[index].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Text(
                        recentProvider[index].price.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recentProvider.length,
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
