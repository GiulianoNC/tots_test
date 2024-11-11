import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

class ClientUpdateState extends Equatable{

  final int id;
  final BlocFormItem firstname;
  final BlocFormItem lastname;
  final BlocFormItem email;
  final File? file;
  final String? imagePath;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const ClientUpdateState({
    this.id = 0,
    this.firstname = const BlocFormItem(error:'Ingresa el nombre'),
    this.lastname =const BlocFormItem(error:'Ingresa el apellido'),
    this.email =const BlocFormItem(error:'Ingresa el mail'),
    this.formKey,
    this.file,
    this.imagePath,
    this.response
  });


  ClientUpdateState resetForm(){
    return ClientUpdateState(
      file:null,
      imagePath: null
    );

  }

  toClient() => Client(
    firstname: firstname.value,
    lastname: lastname.value,
    email: email.value,
    photo: imagePath,
  );

  ClientUpdateState copyWith({
    int? id,
    BlocFormItem? firstname,
    BlocFormItem? lastname,
    BlocFormItem? email,
    File? file,
    String? imagePath,
    GlobalKey<FormState>? formKey,
    Resource? response
  }){
    return ClientUpdateState(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      file: file?? this.file,
      imagePath: imagePath ?? this.imagePath,
      formKey: formKey,
      response: response
    );
  }

  @override
  List<Object?> get props => [id,firstname, lastname, email, file, imagePath, response];

}