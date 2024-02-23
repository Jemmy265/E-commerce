import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/domain/model/CategoryDto.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/ui/components/GenericErrorWidget.dart';
import 'package:ecommerce/ui/components/InfiniteLoadingWidget.dart';
import 'package:ecommerce/ui/components/ProductWidget.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/Brands_Section/brands_section.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/category_section/categories_section.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/Brands_Section/home_brand_item.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/category_section/home_category_item.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/home_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeTabViewState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return InfiniteLoadingWidget(
            loadingMessage: state.loadingMessage ?? "",
          );
        } else if (state is InitialState) {
          return InfiniteLoadingWidget(
            loadingMessage: "",
          );
        } else if (state is SuccessState) {
          return buildSuccesWidget(
              state.CategoriesList, state.brands ?? [], state.products ?? []);
        } else if (state is FailState) {
          return GenericErrorWidget(
              state.message ?? state.exception.toString() ?? "");
        }
        return Container();
      },
      // buildWhen: (previous, current) {
      //   if (current is LoadingState)return false;
      //   if (current is FailState)return false;
      //   return true;
      // },
      // listenWhen: (previous, current) {
      //   if (current is LoadingState)return true;
      //   if (current is FailState)return true;
      //   return false;
      // },
      listener: (context, state) {},
    );
  }

  Widget buildSuccesWidget(List<CategoryDto> categories, List<Brand> brands,
      List<Product> products) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox.fromSize(
                size: Size.fromHeight(MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Popular Categories "),
                        Text("See all"),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12),
                          itemBuilder: (context, index) {
                            return HomeCategoryItem(categories[index]);
                          },
                          itemCount: categories.length),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 170,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Popular Brands "),
                        Text("See all"),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return HomeBrandItem(brands[index]);
                          },
                          itemCount: brands.length),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.33,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Most Selling Products"),
                        Text("See all"),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                width: 10,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductWidget(products[index]);
                          },
                          itemCount: products.length),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
