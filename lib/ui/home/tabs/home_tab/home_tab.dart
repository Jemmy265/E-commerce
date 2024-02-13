import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/ui/components/GenericErrorWidget.dart';
import 'package:ecommerce/ui/components/InfiniteLoadingWidget.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/category_section/categories_section.dart';
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
          return CategoriesSection(state.CategoriesList);
        } else if (state is FailState) {
          return GenericErrorWidget(state.message??state.exception.toString()??"");
        }
        return Container();
      },
      listener: (context, state) {

      },
    );
  }
}
