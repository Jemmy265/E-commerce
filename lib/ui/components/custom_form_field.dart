import 'package:flutter/material.dart';

typedef Myvalidator = String? Function(String?);

class CustomFormField extends StatelessWidget {
  bool isPassword;
  TextInputType keyboardType;
  String label;
  String hint;
  TextEditingController controller;
  Myvalidator validator;
  int lines;
  CustomFormField({
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.label,
    required this.validator,
    required this.controller,
    required this.hint,
    this.lines = 1,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 8,),
          TextFormField(
            maxLines: lines,
            minLines: lines,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),


            ),
          ),
        ],
      ),
    );
  }
}
