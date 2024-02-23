import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/domain/dataSource/Brands_DataSource.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrandsDataSource)
class BrandsOnlineDataSource extends BrandsDataSource {
  ApiManager apiManager;

  BrandsOnlineDataSource(this.apiManager);

  @override
  Future<List<Brand>?> getBrands() async {
    var response = await apiManager.getBrands();
    return response.data?.map((brandDto) => brandDto.toBrand()).toList();
  }
}
