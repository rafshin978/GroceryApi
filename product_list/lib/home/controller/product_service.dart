import 'package:hive/hive.dart';
import '../model_home.dart';


class ProductService {
  final String _boxName = 'products';

  Future<Box<Product>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Product>(_boxName);
    }
    return Hive.box<Product>(_boxName);
  }

  Future<void> addProduct(Product product) async {
    final box = await _openBox();
    await box.put(product.id, product);
  }

  Future<Product?> getProduct(int id) async {
    final box = await _openBox();
    return box.get(id);
  }

  Future<List<Product>> getAllProducts() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> updateProduct(Product product) async {
    final box = await _openBox();
    await box.put(product.id, product);
  }

  Future<void> deleteProduct(int id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
