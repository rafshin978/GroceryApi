import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_list/customer/user_model.dart';
import 'package:product_list/utils/app_text.dart';

import 'home/features/home_page.dart';
import 'home/model_home.dart';



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('products');
  Hive.registerAdapter(ProductDetailsAdapter());
  await Hive.openBox<ProductDetails>('productDetails');
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<ProductDetails>('userDetails');
  Hive.registerAdapter(UserDetailsAdapter());
  await Hive.openBox<ProductDetails>('userDetailsId');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppText.appName,
      home: HomePage(),
    );
  }
}
