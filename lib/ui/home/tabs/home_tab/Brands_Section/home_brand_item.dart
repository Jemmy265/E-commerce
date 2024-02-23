import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/domain/model/CategoryDto.dart';
import 'package:flutter/material.dart';

class HomeBrandItem extends StatelessWidget {
  Brand brand;

  HomeBrandItem(this.brand);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          width: 80,
          height: 80,
          imageUrl: brand.image ?? "",
          placeholder: (context, url) =>
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Text(
          brand.name ?? "",
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
