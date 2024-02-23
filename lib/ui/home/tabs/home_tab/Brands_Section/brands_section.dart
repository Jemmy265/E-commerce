import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/Brands_Section/home_brand_item.dart';
import 'package:flutter/cupertino.dart';

class BrandsSection extends StatelessWidget {
  List<Brand> brands;

  BrandsSection(this.brands);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (context, index) {
          return HomeBrandItem(brands[index]);
        },
        itemCount: brands.length ?? 0,
      ),
    );
  }
}
