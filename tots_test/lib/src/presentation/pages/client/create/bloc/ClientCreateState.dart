import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

class ClientCreateState extends Equatable {
  final BlocFormItem firstname;
  final BlocFormItem lastname;
  final BlocFormItem email;
  final BlocFormItem address;
  final BlocFormItem photo;
  final BlocFormItem caption;
  final String? imagePath;
  final GlobalKey<FormState> formKey; // Non-constant
  final Resource? response;
  final File? file;

  ClientCreateState({
    this.firstname = const BlocFormItem(error: 'Ingresa el nombre'),
    this.lastname = const BlocFormItem(error: 'Ingresa el apellido'),
    this.email = const BlocFormItem(error: 'Ingresa el email'),
    this.photo = const BlocFormItem(error: 'Ingresa la foto'),
    this.address = const BlocFormItem(error: 'Ingresa la dirección'),
    this.caption = const BlocFormItem(),
    this.imagePath,
    GlobalKey<FormState>? formKey, // Nullable parameter without default const value
    this.file,
    this.response,
  }) : formKey = formKey ?? GlobalKey<FormState>(); // Assign a new instance if null

  Client toClient() => Client(
    firstname: firstname.value,
    lastname: lastname.value,
    email: email.value,
    photo: imagePath
  );

  ClientCreateState ClientResetForm() {
    return ClientCreateState(
      firstname: const BlocFormItem(error: 'Ingresa el nombre'),
      lastname: const BlocFormItem(error: 'Ingresa el apellido'),
      email: const BlocFormItem(error: 'Ingresa el email'),
      address: const BlocFormItem(error: 'Ingresa la dirección'),
      photo: const BlocFormItem(error: 'Ingresa la captura'),
      caption: const BlocFormItem(error: 'Ingresa la captura'),
      imagePath: null
    );
  }

  ClientCreateState resetForm(){
    return ClientCreateState(
      file:null,
      imagePath: null
    );

  }

  ClientCreateState copyWith({
    BlocFormItem? firstname,
    BlocFormItem? lastname,
    BlocFormItem? email,
    BlocFormItem? address,
    BlocFormItem? photo,
    BlocFormItem? caption,
    GlobalKey<FormState>? formKey,
    Resource? response,
    File? file,
    String? imagePath,
  }) {
    return ClientCreateState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      address: address ?? this.address,
      caption: caption ?? this.caption,
      photo: photo ?? this.photo,
      imagePath: imagePath ?? this.imagePath,
      formKey: formKey ?? this.formKey,
      response: response ?? this.response,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [firstname, lastname, email,photo,imagePath, address, caption, file, response];
}
