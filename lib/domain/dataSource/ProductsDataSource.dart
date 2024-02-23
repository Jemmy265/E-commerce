import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/product_repository.dart';

abstract class ProductsDataSource {
  Future<List<Product>?> getProducts({ProductSort? sortBy});
}
