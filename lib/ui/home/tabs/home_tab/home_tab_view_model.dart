import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/data/dataSource/Categories_online_dataSource_impl.dart';
import 'package:ecommerce/data/repository/CategoriesRepository.dart';
import 'package:ecommerce/domain/customException/NetworkException.dart';
import 'package:ecommerce/domain/customException/ServerError.dart';
import 'package:ecommerce/domain/dataSource/categories_online_dataSource.dart';
import 'package:ecommerce/domain/model/CategoryDto.dart';
import 'package:ecommerce/domain/model/CategoryResultDto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';
import 'package:ecommerce/domain/usecase/GetCategoriesUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabViewModel extends Cubit<HomeTabViewState> {
  late GetCategoriesUseCase useCase;

  HomeTabViewModel():super(InitialState()){
    ApiManager apiManager = ApiManager();
    CategoriesOnlineDataSource dataSource = CategoriesOnlineDataSourceImpl(apiManager);
    CategoriesRepository repository = CategoriesRepositoryImpl(dataSource);
    useCase = GetCategoriesUseCase(repository);
  }
  CategoryResultDto? _categoryResultDto;
  void getAllCategories() async{
    emit(LoadingState());
    try {
      var result = await useCase.invoke();
      _categoryResultDto = result;
      emit(SuccessState(result.categoriesList!));
    }on ServerError catch (ex) {
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
  SuccessState(this.CategoriesList);
}

class FailState extends HomeTabViewState {
  String? message;
  Exception? exception;

  FailState({this.message, this.exception});
}