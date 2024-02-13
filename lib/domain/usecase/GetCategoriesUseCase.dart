import 'package:ecommerce/domain/model/CategoryResultDto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future <CategoryResultDto> invoke({String? KeyWord, int page = 1, int limit = 0}){
    return repository.getCategories();
  }
}