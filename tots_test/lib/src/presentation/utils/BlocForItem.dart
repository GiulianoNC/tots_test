class BlocFormItem {
  final String value;
  final String? error;

  const BlocFormItem({this.value = '', this.error =''});

  BlocFormItem copyWith({String? value, String? error}) {
    return BlocFormItem(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }

  // Método para validar si el campo es válido
  bool get isValid => value.isNotEmpty && (error == null || error!.isEmpty);
}
