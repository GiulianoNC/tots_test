import 'package:flutter/material.dart';

class DefaultTextfield extends StatelessWidget {
  final String label;
  final String? initialValue;
  final String? errorText;
  final TextInputType? textInputType;
  final Color color;
  final Function(String text) onChanged;
  final bool obscureText; // Indica si el campo debe iniciar oculto
  final bool showEyeIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleObscure; // Para gestionar el cambio de visibilidad desde fuera

  const DefaultTextfield({
    Key? key,
    required this.label,
    this.errorText = '',
    required this.onChanged,
    this.obscureText = false,
    this.showEyeIcon = false,
    this.initialValue,
    this.color = const Color.fromARGB(255, 124, 123, 123),
    this.textInputType = TextInputType.text,
    this.validator,
    this.onToggleObscure, // Para recibir la función que cambia el valor de obscureText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      onChanged: (text) => onChanged(text),
      keyboardType: textInputType,
      validator: validator,
      decoration: InputDecoration(
        errorText: errorText,
        label: Text(
          label,
          style: TextStyle(color: color),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        suffixIcon: showEyeIcon
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: color,
                ),
                onPressed: onToggleObscure, // Cambiar el valor de obscureText externamente
              )
            : null,
      ),
      style: TextStyle(color: color),
    );
  }
}
