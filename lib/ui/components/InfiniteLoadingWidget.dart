import 'package:flutter/material.dart';

class InfiniteLoadingWidget extends StatelessWidget {
  String? loadingMessage;
  InfiniteLoadingWidget({this.loadingMessage});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        CircularProgressIndicator(color: Theme.of(context).primaryColor),
        Text(loadingMessage??"")
      ],
    ),);
  }
}
