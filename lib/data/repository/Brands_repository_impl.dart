import 'package:ecommerce/domain/dataSource/Brands_DataSource.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/domain/repository/brands_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrandsRepository)
class BrandsRepositoryImpl extends BrandsRepository {
  BrandsDataSource brandsDataSource;

  BrandsRepositoryImpl(this.brandsDataSource);

  @override
  Future<List<Brand>?> getBrands() {
    return brandsDataSource.getBrands();
  }
}
