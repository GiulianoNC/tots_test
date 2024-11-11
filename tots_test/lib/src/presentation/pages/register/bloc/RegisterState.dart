import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tots_test/src/domain/models/User.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

class RegisterState extends Equatable{

  final BlocFormItem firstName;
  final BlocFormItem email;
  final BlocFormItem password;
  final BlocFormItem confirmPassword;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const RegisterState({
    this.firstName = const BlocFormItem(error: 'ingresa el nombre'),
    this.email = const BlocFormItem(error: 'ingresa el email'),
    this.password = const BlocFormItem(error: 'ingresa el password'),
    this.confirmPassword = const BlocFormItem(error: 'Confirma el password'),
    this.formKey,
    this.response

  });

  toUser() {
  return User(
    firstName: firstName.value,
    password: password.value,
    email: email.value,
  );
}


  RegisterState copyWith({
    BlocFormItem? firstName,
    BlocFormItem? email,
    BlocFormItem? password,
    BlocFormItem? confirmPassword,
    GlobalKey<FormState>? formKey,
    Resource? response
  }){
    return  RegisterState(
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formKey: formKey,
      response: response

    );
  }

  @override
  List<Object?> get props => [firstName, email, password,confirmPassword,response];


}