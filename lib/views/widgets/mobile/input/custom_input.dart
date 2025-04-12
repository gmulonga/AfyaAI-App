import 'package:flutter/material.dart';
import 'package:afyaai/utils/constants.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  InputField({
    required this.hintText,
    this.password = false,
    this.onChanged,
    this.integerOnly = false,
    this.errorText,
    this.isEnabled = true,
    this.controller,
    this.onTap,
    this.isRequired = false,
    this.validator,
    required this.label,
    this.maxLines = 1,
  });

  final String label;
  final String hintText;
  final bool password;
  final ValueChanged<String>? onChanged;
  final bool integerOnly;
  final String? errorText;
  final bool isEnabled;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool isRequired;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? _errorMessage;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(widget.label),
          ),
          TextField(
            obscureText: widget.password ? _obscureText : false,
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              setState(() {
                if (widget.validator != null) {
                  _errorMessage = widget.validator!(value);
                } else if (widget.isRequired && value.isEmpty) {
                  _errorMessage = "This field is required";
                } else {
                  _errorMessage = null;
                }
              });

              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            controller: widget.controller,
            onTap: widget.onTap,
            inputFormatters:
            widget.integerOnly
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: kGrey),
              errorText: _errorMessage ?? widget.errorText,
              fillColor: kWhite,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kGreen, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kGrey, width: 1.0),
              ),
              suffixIcon:
              widget.password
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: kGreen,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}