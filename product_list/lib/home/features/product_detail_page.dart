import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list/utils/app_size.dart';
import 'package:product_list/utils/app_text.dart';
import '../controller/home_screen_controller.dart';
import '../model_home.dart';


class ProductDetailScreen extends StatelessWidget {
  final int productId;
  final ProductController productController = Get.find<ProductController>();

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    productController.fetchProductDetail(productId);

    return Scaffold(
      appBar: AppBar(title: const Text(AppText.appbarProducts)),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.productDetail.value == null) {
          //print(productController.productDetail.value.name);
          return const Center(child: Text(AppText.noProductsError));
        } else {
          ProductDetails product = productController.productDetail.value!;
          print('Displaying product: $product');
          return Padding(
            padding: const EdgeInsets.all(AppSizes.md_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                  child: Image.network(
                    'http://143.198.61.94:8000${product.image}',
                    fit: BoxFit.cover,
                    height: AppSizes.boxFitHeight,
                  ),
                ),
                const SizedBox(height: AppSizes.md_16),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'Pacific',
                    fontSize:AppSizes.fontSizeLg,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.md_16),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeLg,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

