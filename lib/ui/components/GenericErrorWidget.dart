import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  String errorMessage;
  String? actionName;
  VoidCallback? action;
  GenericErrorWidget( this.errorMessage, {super.key, this.action, this.actionName});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text(errorMessage),
        actionName!= null? ElevatedButton(onPressed: action, child: Text(actionName!)):Container()
      ],
    ),);
  }
}
