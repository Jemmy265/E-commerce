import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMostSellingProducts {
  ProductsRepository productsRepository;

  GetMostSellingProducts(this.productsRepository);

  Future<List<Product>?> invoke() {
    return productsRepository.getProducts(sortBy: ProductSort.mostSelling);
  }
}
