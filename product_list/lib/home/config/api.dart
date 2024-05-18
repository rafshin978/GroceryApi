// lib/config.dart
class Config {
  static const String baseUrl = 'http://143.198.61.94:8000/api/';

  static String getProductsEndpoint() {
    return '${baseUrl}products/';
  }


  final String endpoint = 'customers/';

}