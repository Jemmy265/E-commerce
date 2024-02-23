import 'package:ecommerce/domain/model/Brand.dart';

abstract class BrandsRepository {
  Future<List<Brand>?> getBrands();
}
