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
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider),
              ),
            );
          },
          width: 100,
          height: 100,
          imageUrl: category.image ?? "",
          placeholder: (context, url) =>
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
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
