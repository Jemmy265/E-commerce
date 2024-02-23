import 'package:ecommerce/domain/model/CategoryDto.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/category_section/home_category_item.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  List<CategoryDto> categories;
  CategoriesSection(this.categories);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return HomeCategoryItem(categories[index]);
      },
      itemCount: categories.length ?? 0,
    );
  }
}
