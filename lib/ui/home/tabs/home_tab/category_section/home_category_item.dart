import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/CategoryDto.dart';
import 'package:flutter/material.dart';

class HomeCategoryItem extends StatelessWidget {
  CategoryDto category;
  HomeCategoryItem(this.category);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          width: 120,
          height: 120,
          imageUrl: category.image??"",
          placeholder: (context, url) => CircularProgressIndicator(color: Theme.of(context).primaryColor),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        SizedBox(height: 12,),
        Text(
          category.name??"",
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
