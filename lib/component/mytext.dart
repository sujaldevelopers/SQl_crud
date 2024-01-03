import 'package:flutter/material.dart';

class mttext extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?)? validator;
  int? maxlenth;
  String hinttext;
  mttext({super.key,required this.controller , this.maxlenth,this.validator, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLength: maxlenth,
        decoration: InputDecoration(
            hintText: hinttext,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    );
  }
}
/**
 * CREATE TABLE MANGUKIYA(id INTEGER AUTOINCREMENT)
 * select * from MANGUKIYA
 * UPDATE MAGUKIYA SET id = '1' WHERE id = '1'
 * DELETE FROM MANGUKIYA WHERE id='1'
 */
