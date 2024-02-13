import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/domain/dataSource/categories_online_dataSource.dart';
import 'package:ecommerce/domain/model/CategoryResultDto.dart';

class CategoriesOnlineDataSourceImpl implements CategoriesOnlineDataSource {
  ApiManager apiManager;
  CategoriesOnlineDataSourceImpl(this.apiManager);
  @override
  Future<CategoryResultDto> getCategories({String? CategorySlug,int limit = 0,int page = 1}) async {
    var data = await apiManager.getCategories(CategorySlug: CategorySlug, limit: limit,page: page);
    return CategoryResultDto(
      categoriesList: data.data?.map((entity) => entity.toCategoryDto()).toList(),
      paginationDto: data.pagination?.toPaginationDto()
    );
  }

}