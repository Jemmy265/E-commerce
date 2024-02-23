import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/data/dataSource/Categories_online_dataSource_impl.dart';
import 'package:ecommerce/data/repository/CategoriesRepository.dart';
import 'package:ecommerce/domain/customException/NetworkException.dart';
import 'package:ecommerce/domain/customException/ServerError.dart';
import 'package:ecommerce/domain/dataSource/categories_online_dataSource.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/domain/model/CategoryDto.dart';
import 'package:ecommerce/domain/model/CategoryResultDto.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';
import 'package:ecommerce/domain/usecase/GetBrandsUsecase.dart';
import 'package:ecommerce/domain/usecase/GetCategoriesUseCase.dart';
import 'package:ecommerce/domain/usecase/GetMostSellingProductUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../di/di.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabViewState> {
  GetCategoriesUseCase categoriesUseCase;
  GetBrandsUseCase brandsUseCase;
  GetMostSellingProducts productsUseCase;

  HomeTabViewModel(
      this.categoriesUseCase, this.brandsUseCase, this.productsUseCase)
      : super(InitialState());
  CategoryResultDto? _categoryResultDto;

  void getAllCategories() async {
    emit(LoadingState());
    try {
      var categories = await categoriesUseCase.invoke();
      var brands = await brandsUseCase.invoke();
      var products = await productsUseCase.invoke();
      _categoryResultDto = categories;
      emit(SuccessState(categories.categoriesList!, brands, products));
    } on ServerError catch (ex) {
      emit(FailState(message: ex.errorMessage, exception: ex));
    } on NetworkException catch (ex) {
      emit(FailState(
          message: "Please check your internet connection", exception: ex));
    }
  }
}

abstract class HomeTabViewState {}

class InitialState extends HomeTabViewState {

}

class LoadingState extends HomeTabViewState {
  String? loadingMessage;
  LoadingState({this.loadingMessage});
}

class SuccessState extends HomeTabViewState {
  List<CategoryDto> CategoriesList;
  List<Brand>? brands;
  List<Product>? products;

  SuccessState(this.CategoriesList, this.brands, this.products);
}

class FailState extends HomeTabViewState {
  String? message;
  Exception? exception;

  FailState({this.message, this.exception});
}