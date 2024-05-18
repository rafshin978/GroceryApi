import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'product_service.dart';
import '../config/api.dart';
import '../model_home.dart';


class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  final ProductService productService = ProductService();
  var productDetail = Rx<ProductDetails?>(null);

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      final url = Uri.parse(Config.getProductsEndpoint());
      final response = await http.get(url);
      //print('Response: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        //print('Response Data: $responseData');

        if (responseData['data'] != null) {
          final List<dynamic> data = responseData['data'];
          for (var item in data) {
            try {
              final product = Product.fromJson(item);
              //print('Product from JSON: $product');
              await productService.addProduct(product);
            } catch (e) {
              //print('Error converting item to Product: $e');
            }
          }

          products.value = await productService.getAllProducts();
          //print("Products loaded: ${products.length}");
        } else {
          //print('No data available');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      //print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductDetail(int id) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://143.198.61.94:8000/api/products/?id=$id'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        //print('Fetched product details: $data'); // Logging the response data
        productDetail.value = ProductDetails.fromJson(data);
        //print('Parsed product detail: ${productDetail.value}'); // Logging the parsed data
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching product details');
      //print('Error fetching product details: $e'); // Logging the error
    } finally {
      isLoading(false);
    }
  }
}





