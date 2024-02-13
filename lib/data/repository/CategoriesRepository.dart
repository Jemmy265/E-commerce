import 'package:ecommerce/domain/dataSource/categories_online_dataSource.dart';
import 'package:ecommerce/domain/model/CategoryResultDto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesOnlineDataSource dataSource;

  CategoriesRepositoryImpl(this.dataSource);

  @override
  Future<CategoryResultDto> getCategories({String? CategorySlug, int limit = 0, int page = 1}) {
    return dataSource.getCategories(CategorySlug: CategorySlug,limit: limit,page: page);
  }


}