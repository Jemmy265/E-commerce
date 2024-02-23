// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/Api_Manager.dart' as _i3;
import '../data/dataSource/auth_online_dataSource_impl.dart' as _i5;
import '../data/dataSource/Brands_Online_DataSource.dart' as _i9;
import '../data/dataSource/Categories_online_dataSource_impl.dart' as _i13;
import '../data/dataSource/Products_Online_DataSource.dart' as _i21;
import '../data/repository/auth_repository.dart' as _i7;
import '../data/repository/Brands_repository_impl.dart' as _i11;
import '../data/repository/CategoriesRepository.dart' as _i15;
import '../data/repository/ProductsRepository.dart' as _i23;
import '../domain/dataSource/auth_online_dataSource.dart' as _i4;
import '../domain/dataSource/Brands_DataSource.dart' as _i8;
import '../domain/dataSource/categories_online_dataSource.dart' as _i12;
import '../domain/dataSource/ProductsDataSource.dart' as _i20;
import '../domain/repository/auth_repository.dart' as _i6;
import '../domain/repository/brands_repository.dart' as _i10;
import '../domain/repository/categories_repository.dart' as _i14;
import '../domain/repository/product_repository.dart' as _i22;
import '../domain/usecase/GetBrandsUsecase.dart' as _i16;
import '../domain/usecase/GetCategoriesUseCase.dart' as _i17;
import '../domain/usecase/GetMostSellingProductUseCase.dart' as _i26;
import '../domain/usecase/login_usecase.dart' as _i18;
import '../domain/usecase/register_usecase.dart' as _i24;
import '../ui/home/tabs/home_tab/home_tab_view_model.dart' as _i27;
import '../ui/login/login_viewModel.dart' as _i19;
import '../ui/register/register_viewModel.dart' as _i25;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiManager>(_i3.ApiManager());
    gh.factory<_i4.AuthOnlineDataSource>(
        () => _i5.AuthOnlineDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i6.AuthRepository>(
        () => _i7.AuthRepositoryImpl(gh<_i4.AuthOnlineDataSource>()));
    gh.factory<_i8.BrandsDataSource>(
        () => _i9.BrandsOnlineDataSource(gh<_i3.ApiManager>()));
    gh.factory<_i10.BrandsRepository>(
        () => _i11.BrandsRepositoryImpl(gh<_i8.BrandsDataSource>()));
    gh.factory<_i12.CategoriesOnlineDataSource>(
        () => _i13.CategoriesOnlineDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i14.CategoriesRepository>(() =>
        _i15.CategoriesRepositoryImpl(gh<_i12.CategoriesOnlineDataSource>()));
    gh.factory<_i16.GetBrandsUseCase>(
        () => _i16.GetBrandsUseCase(gh<_i10.BrandsRepository>()));
    gh.factory<_i17.GetCategoriesUseCase>(
        () => _i17.GetCategoriesUseCase(gh<_i14.CategoriesRepository>()));
    gh.factory<_i18.LoginUseCase>(
        () => _i18.LoginUseCase(gh<_i6.AuthRepository>()));
    gh.factory<_i19.LoginViewModel>(
        () => _i19.LoginViewModel(gh<_i18.LoginUseCase>()));
    gh.factory<_i20.ProductsDataSource>(
        () => _i21.ProductsOnlineDataSource(gh<_i3.ApiManager>()));
    gh.factory<_i22.ProductsRepository>(
        () => _i23.ProductsRepositoryImpl(gh<_i20.ProductsDataSource>()));
    gh.factory<_i24.RegisterUseCase>(
        () => _i24.RegisterUseCase(gh<_i6.AuthRepository>()));
    gh.factory<_i25.RegisterViewModel>(
        () => _i25.RegisterViewModel(gh<_i24.RegisterUseCase>()));
    gh.factory<_i26.GetMostSellingProducts>(
        () => _i26.GetMostSellingProducts(gh<_i22.ProductsRepository>()));
    gh.factory<_i27.HomeTabViewModel>(() => _i27.HomeTabViewModel(
          gh<_i17.GetCategoriesUseCase>(),
          gh<_i16.GetBrandsUseCase>(),
          gh<_i26.GetMostSellingProducts>(),
        ));
    return this;
  }
}
