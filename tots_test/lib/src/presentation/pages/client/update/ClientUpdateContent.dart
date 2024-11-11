import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateBloc.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';
import 'package:tots_test/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:tots_test/src/presentation/widgets/Default_textfield.dart';

class ClientUpdateContent extends StatelessWidget {
  
  ClientUpdateBloc? bloc;
  ClientUpdateState state;
  Client? client;

  ClientUpdateContent(this.bloc,this.state,this.client);

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _imageBackGround(context),
          
          SingleChildScrollView(
            child: Container(
              //height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textUpdateInfo(),
                  _imageClient(context),
                  //Spacer(),
                  _cardClientInfo(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageBackGround(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.white, 
  );
}


  Widget _imageClient(BuildContext context){
    return GestureDetector(
      onTap: (){
        SelectOptionImageDialog(
          context,
          (){bloc?.add(ClientUpdatePickImage());}, 
          (){bloc?.add(ClientUpdateTakePhoto());}, 
        );
      },
      child: Container(
        width: 150,
        //margin: EdgeInsets.only(top:10),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child:state.file != null 
              ? Image.file(
                state.file!,
                fit: BoxFit.cover,
              )
                  : client != null && client!.photo != null && client!.photo!.isNotEmpty
                  ? _getClientImage(client!.photo!)
              :Image.asset('assets/img/no-image.png',
              fit: BoxFit.cover),
              ),
            ),
        ),
    );
  }

  Widget _getClientImage(String photoPath) {
  // Si es una URL válida
    if (photoPath.startsWith('http') || photoPath.startsWith('https')) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/img/user_image.png',
        image: photoPath,
        fit: BoxFit.cover,
        fadeInDuration: Duration(seconds: 1),
      );
    }
    // Si es una ruta de archivo local
    else if (File(photoPath).existsSync()) {
      return Image.file(
        File(photoPath),
        fit: BoxFit.cover,
      );
    }
    // Si no es válida, se usa una imagen predeterminada
    return Image.asset(
      'assets/img/no-image.png',
      fit: BoxFit.cover,
    );
  }

  
  Widget _textUpdateInfo(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top:125, left:35),
      child:Text('Edit Client',
      style: TextStyle(
        fontSize: 17
      ),
      ),
    );
  }
  
  Widget _textFieldFirstName(){
    return Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        child: DefaultTextfield(
          label: 'First name',
          color: Colors.black,
          initialValue: client?.firstname ?? '',
          onChanged: (text){
            bloc?.add(ClientUpdateFirstNameChanged(firstname: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.lastname.error;
          },
        )
    );
  }

  Widget _textFieldLastName(){
    return Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        child: DefaultTextfield(
          label: 'Last name',
          color: Colors.black,
          initialValue: client?.lastname ?? '',
          onChanged: (text){
            bloc?.add(ClientUpdateLastNameChanged(lastname: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.lastname.error;
          },
        )
    );
  }

  Widget _textFieldEmail(){
    return Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        child: DefaultTextfield(
          label: 'Email',
          color: Colors.black,
          initialValue: client?.email ?? '',
          onChanged: (text){
            bloc?.add(ClientUpdateEmailChanged(email: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.email.error;
          },
        )
    );
  }

  Widget _cardClientInfo(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height *0.45,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(35),
          topRight: Radius.circular(35)
        )
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _textFieldFirstName(),
              _textFieldLastName(),
              _textFieldEmail(),
              _buttons(context)
            ],
          ),
      ),
    );
  }

  Widget _buttons(BuildContext context){
    return Row(
      children: [
        Container(
          height: 40,
          width: 135,
          margin: EdgeInsets.only( left: 5,top: 20),
            child: ElevatedButton(
            onPressed:(){
              Navigator.pushReplacementNamed(context, 'clienpage');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white
            ),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ),
      Spacer(), 
        Container(
          height: 40,
          width: 159,
          margin: EdgeInsets.only(right: 5),
            child: ElevatedButton(
            onPressed:(){
              bloc?.add(ClientUpdateFormSubmit());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black
            ),
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )  
      ],
    );
  }

}