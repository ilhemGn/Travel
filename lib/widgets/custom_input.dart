import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixText,
    required this.validator,
    required this.onSave,
  });

  final String hintText;
  final String labelText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? Function(String?)? validator;
  final Function(String?)? onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixText: prefixText ?? '',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(26)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 193, 193, 193),
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
          validator: validator,
          onSaved: onSave,
        ),
      ],
    );
  }
}
