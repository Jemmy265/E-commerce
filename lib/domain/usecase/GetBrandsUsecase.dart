import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/domain/repository/brands_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBrandsUseCase {
  BrandsRepository brandsRepository;

  GetBrandsUseCase(this.brandsRepository);

  Future<List<Brand>?> invoke() {
    return brandsRepository.getBrands();
  }
}
