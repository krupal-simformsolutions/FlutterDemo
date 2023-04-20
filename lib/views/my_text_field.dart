import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.isPassword,
      required this.validator})
      : super(key: key);
  final String icon;
  final String hint;
  final bool isPassword;
  final FormFieldValidator<String?> validator;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: textEditingController,
      obscureText: widget.isPassword,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        prefixIcon: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.orange.withAlpha(40),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset(widget.icon),
        ),
      ),
    );
  }
}
