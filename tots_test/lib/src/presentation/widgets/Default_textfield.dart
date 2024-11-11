import 'package:flutter/material.dart';

class DefaultTextfield extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String? errorText;
  final TextInputType? textInputType;
  final Color color;
  final Function(String text) onChanged;
  final bool obscureText; // PARA LA CONTRASEÑA
  final String? Function(String?)? validator;
  final bool showEyeIcon; // Nuevo parámetro para mostrar el ícono del ojo

  DefaultTextfield({
    Key? key,
    required this.label,
    this.errorText = '',
    required this.onChanged,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.color = const Color.fromARGB(255, 124, 123, 123),
    this.textInputType = TextInputType.text,
    this.showEyeIcon = false, // Valor predeterminado es false
  }) : super(key: key);

  @override
  _DefaultTextfieldState createState() => _DefaultTextfieldState();
}

class _DefaultTextfieldState extends State<DefaultTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      initialValue: widget.initialValue,
      onChanged: (text) {
        widget.onChanged(text);
      },
      keyboardType: widget.textInputType,
      validator: widget.validator,
      decoration: InputDecoration(
        errorText: widget.errorText,
        label: Text(
          widget.label,
          style: TextStyle(color: widget.color),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.color),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.color),
        ),
        suffixIcon: widget.showEyeIcon
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: widget.color,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; 
                  });
                },
              )
            : null, 
      ),
      style: TextStyle(color: widget.color),
    );
  }
}
