import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  bool? enabled = true;
  bool obscureText = false;
  TextInputType? textInputType;
  TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  double? width;

  AppTextField(
      {Key? key,
      this.text,
      this.icon,
      this.onChanged,
      this.textInputType,
      this.color,
      this.iconColor,
      this.controller,
      this.validator,
      this.width,
      required this.obscureText,
      this.enabled})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isErrorVisible = false;
  String showErrorValidation = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: _isErrorVisible ? size.height * 0.08 : size.height * 0.08,
      width: widget.width != null ? widget.width : size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent)),
      child: TextFormField(
        keyboardType: widget.textInputType,
        controller: widget.controller,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        // style: AppStyles.hintTextAuth,
        decoration: InputDecoration(
          filled: true,
          // fillColor: widget.color,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.height * 0.03),
          prefixIcon:
              widget.text == 'Password' || widget.text == 'Confirm Password'
                  ? IconButton(
                      icon: Icon(
                        widget.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: widget.iconColor,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                    )
                  : widget.icon != null
                      ? Icon(
                          widget.icon,
                          color: widget.iconColor,
                        )
                      : null,
          hintText: widget.text ?? "",
          // hintStyle: AppStyles.hintTextAuth,
          border: OutlineInputBorder(
            // Generic border to specify borderRadius
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none, // Use borderSide.none for no border
          ),
          enabledBorder: OutlineInputBorder(
            // Enabled border with borderRadius
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                width: 2,
                color: AppColors.black.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            // Enabled border with borderRadius
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                width: 2,
                color: AppColors.black.withOpacity(0.5)),
          ),
        ),
        onChanged: widget.onChanged,
        validator: (value) {
          String? validationResult = widget.validator!(value);
          setState(() {
            _isErrorVisible = validationResult != null;
            showErrorValidation = validationResult.toString();
          });
          return validationResult;
        },
      ),
    );
  }
}
