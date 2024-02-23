import 'package:ecommerce/domain/model/Brand.dart';

abstract class BrandsDataSource {
  Future<List<Brand>?> getBrands();
}
