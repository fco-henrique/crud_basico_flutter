import 'package:crud_basico/view/commun/components/CustomFormField.dart';
import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final Widget? preffixIcon;

  const CustomPasswordFormField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.padding,
    this.hintText,
    this.preffixIcon
  });

  @override
  State<CustomPasswordFormField> createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      obscureText: isHidden,
      textEditingController: widget.textEditingController,
      padding: widget.padding,
      hintText: widget.hintText,
      labelText: widget.labelText,
      preffixIcon: widget.preffixIcon,
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(23),
        onTap: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
        child: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
),
    );
  }
}
