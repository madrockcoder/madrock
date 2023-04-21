

import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget {

  final TextEditingController controller;
  const DropDownTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Row(
            children:const [
              Text('USD'),
              Icon(
                  Icons.keyboard_arrow_down_outlined
              )
            ],
          ),

          // TextFormField(
          //   controller: controller,
          //   decoration: InputDecoration(
          //     hintText: "Amount"
          //   ),
          //
          //
          // )

        ]
    );
  }
}
