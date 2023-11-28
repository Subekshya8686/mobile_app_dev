import 'package:flutter/material.dart';

class CommonTextFieldState extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  bool? obscureText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  CommonTextFieldState({super.key,
    this.hintText,required this.controller,this.obscureText=false, this.suffixIcon, this.prefixIcon});

  @override
  State<CommonTextFieldState> createState() => CommonTextFieldStateState();
}

class CommonTextFieldStateState extends State<CommonTextFieldState> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText!,
            decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.black87, width: 1)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.indigo, width: 1)),
            ))
        ;
  }
}
