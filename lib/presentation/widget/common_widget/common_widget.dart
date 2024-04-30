import 'package:flutter/material.dart';

class CommonWidget {
  // common text form field
  textFormFieldWidget(
      {required BuildContext context,
      required String labelText,
      required TextEditingController controller,
      required bool secure,
      bool visible = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          validator: (value) {
            if (value == null || value == '') {
              return 'invalid';
            } else {
              return null;
            }
          },
          obscureText: visible,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: const Color.fromARGB(255, 242, 242, 242),
            filled: true,
            labelText: labelText,
            labelStyle: const TextStyle(
                color: Color.fromARGB(255, 111, 111, 111), fontSize: 16),
          ),
          style: TextStyle(
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
