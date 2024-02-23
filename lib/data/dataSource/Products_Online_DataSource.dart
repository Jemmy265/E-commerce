import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/api/Response/Products/ProductDto.dart';
import 'package:ecommerce/domain/dataSource/ProductsDataSource.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsDataSource)
class ProductsOnlineDataSource implements ProductsDataSource {
  ApiManager apiManager;

  ProductsOnlineDataSource(this.apiManager);

  @override
  Future<List<Product>?> getProducts({ProductSort? sortBy}) async {
    var response = await apiManager.getProducts(sort: sortBy);
    return response.data?.map((ProductDto) => ProductDto.toProduct()).toList();
  }
}
