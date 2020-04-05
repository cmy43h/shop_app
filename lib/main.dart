import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './screens/productOverVeiwScreen.dart';
import './screens/product_detail_screen.dart';
import './screens/recentScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
            color: const Color(0xFF7842E5),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductOverviewScreen(),
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
          RecentScreen.route: (ctx) => RecentScreen()
        },
      ),
    );
  }
}
