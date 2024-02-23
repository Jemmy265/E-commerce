import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                width: 190,
                height: 128,
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 190,
                      height: 128,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    );
                  },
                  width: 100,
                  height: 100,
                  imageUrl: product.imageCover ?? "",
                  placeholder: (context, url) => CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Text(
              '${product.title}\n\n' ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Text(product.description??""),
            Expanded(
              child: Row(
                children: [
                  Text(product.priceAfterDiscount?.toString() ??
                      product.price?.toString() ??
                      ""),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                      visible: product.priceAfterDiscount != null,
                      child: Text(
                        product.priceAfterDiscount?.toString() ?? "",
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reviews (${product.ratingsAverage})"),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(Icons.add)),
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.fromBorderSide(BorderSide(
            width: 2,
            color: Theme.of(context).primaryColor,
          ))),
    );
  }
}
