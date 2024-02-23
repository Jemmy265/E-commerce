import 'package:ecommerce/domain/dataSource/ProductsDataSource.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  ProductsDataSource dataSource;

  ProductsRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>?> getProducts({ProductSort? sortBy}) {
    return dataSource.getProducts(sortBy: sortBy);
  }
}
