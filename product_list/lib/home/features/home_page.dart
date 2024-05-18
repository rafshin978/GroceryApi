import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list/home/features/product_detail_page.dart';
import 'package:product_list/home/features/widgets/drawer_menu.dart';
import 'package:product_list/utils/app_size.dart';
import 'package:product_list/utils/app_text.dart';
import '../controller/home_screen_controller.dart';
import 'package:carousel_slider/carousel_options.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppText.appName)),
      drawer: DrawerMenu(),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.products.isEmpty) {
          return const Center(child: Text(AppText.noProductsError));
        } else {
          return Column(
            children: [
              // Carousel Slider
              Flexible(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: AppSizes.imageCarouseHeight,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: productController.products.map((product) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppSizes.xs_4),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppSizes.cardRadiusLg),
                            child: Card(
                              elevation: AppSizes.cardElevationSm,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      'http://143.198.61.94:8000${product.image}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(AppSizes.sm_8),
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(
                                          fontFamily: AppText.fontFamily,
                                          fontSize: AppSizes.fontSizeMd),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(AppSizes.sm_8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: AppSizes.gridViewCount,
                    crossAxisSpacing: AppSizes.sm_8,
                    mainAxisSpacing: AppSizes.sm_8,
                    childAspectRatio: AppSizes
                        .gridChildRatio, // Adjust the aspect ratio if needed
                  ),
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return GestureDetector(
                      onTap: () {
                        _navigateToProductDetail(product.id);
                      },
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSizes.cardRadiusLg),
                        child: Card(
                          elevation: AppSizes.cardElevationSm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  'http://143.198.61.94:8000${product.image}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppSizes.sm_8),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontSize: AppSizes.fontSizeMd,
                                      fontFamily: AppText.fontFamily
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: productController.fetchProducts,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _navigateToProductDetail(int productId) async {
    await productController.fetchProductDetail(productId);
    Get.to(() => ProductDetailScreen(productId: productId));
  }
}
