import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool? obscureText;

  const CustomFormField({
    super.key,
    this.obscureText,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.padding,
    this.textEditingController,
    this.textCapitalization,
    this.textInputType,
    this.maxLength,
    this.textInputAction,
    this.preffixIcon
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final OutlineInputBorder defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? false,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.preffixIcon,
        labelText: widget.labelText,
        border: defaultBorder,
        focusedBorder: defaultBorder.copyWith(
          borderSide: BorderSide(color: Colors.black)
        ),
        errorBorder: defaultBorder.copyWith(
          borderSide:const BorderSide(color: Colors.red)
        ),
        focusedErrorBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red)
        ),
),
    );
  }
}
