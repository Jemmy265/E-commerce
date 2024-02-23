import 'package:ecommerce/domain/model/Product.dart';

abstract class ProductsRepository {
  Future<List<Product>?> getProducts({
    ProductSort? sortBy,
  });
}

enum ProductSort {
  lowestPrice("price"),
  highestPrice("-price"),
  mostSelling("-sold");

  final String value;

  const ProductSort(this.value);
}
