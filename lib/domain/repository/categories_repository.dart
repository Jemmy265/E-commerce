import 'package:ecommerce/domain/model/CategoryResultDto.dart';

abstract class CategoriesRepository{
  Future<CategoryResultDto> getCategories({String? CategorySlug,int limit = 0,int page = 1});
}