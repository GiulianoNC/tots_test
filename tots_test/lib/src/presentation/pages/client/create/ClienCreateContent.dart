import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateBloc.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';
import 'package:tots_test/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:tots_test/src/presentation/widgets/Default_textfield.dart';

class ClientCreateContent extends StatelessWidget {

  ClientCreateBloc? bloc;
  ClientCreateState state;

  ClientCreateContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                   _textNewClient(),
                   _imageClient(context),
                   _cardClientForm(context)
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _cardClientForm(BuildContext context){
    return Container(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height *0.3,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35)
        )
      ),
      child: Container(
        margin:EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            _textFieldName(),
            _textFieldLastName(),
            _textFieldEmail(),
            SizedBox(width: 16), 
            _buttons(context)
          ],),
      ),
    );
  }

  Widget _buttons(BuildContext context){
    return Row(
      children: [
        Container(
          height: 40,
          width: 135,
          margin: const EdgeInsets.only(top:30, left: 5),
            child: ElevatedButton(
            onPressed:(){
              Navigator.pushReplacementNamed(context, 'clienpage');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 184, 181, 181)
            ),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white),
            ),
          ),
      ),
      Spacer(), 
        Container(
          height: 40,
          width: 159,
          margin: EdgeInsets.only(top:30, right: 5),
            child: ElevatedButton(
            onPressed:(){
              if(state.formKey!.currentState!.validate()){
                bloc?.add(CreateFormSubmit());
              }else{
                Fluttertoast.showToast(
                  msg: 'The form is not valid',
                  toastLength: Toast.LENGTH_LONG
                );
              }             
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black
            ),
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )  
      ],
    );
  }

  

  Widget _textNewClient(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 35, left:10, bottom: 10),
      child: const Text(
        'Add new client',
        style: TextStyle(
          fontSize: 17
        ),
      ),
    );
  }

  Widget _textFieldName() {
  return DefaultTextfield(
    label: 'First name*',
    initialValue: state.firstname.value, 
    onChanged: (text) {
      bloc?.add(FirstNameChanged(firstname: BlocFormItem(value: text)));
    },
    validator: (value) {
      return state.firstname.error?.isNotEmpty == true ? state.firstname.error : null;
    },
    color: Colors.black,
  );
}

  Widget _textFieldLastName() {
    return DefaultTextfield(
      label: 'Last name*',
      initialValue: state.lastname.value,
      onChanged: (text) {
        bloc?.add(LastNameChanged(lastname: BlocFormItem(value: text)));
      },
      validator: (value) {
        return state.lastname.error?.isNotEmpty == true ? state.lastname.error : null;
      },
      color: Colors.black,
    );
  }

  Widget _textFieldEmail() {
    return DefaultTextfield(
      label: 'Email adress*',
      initialValue: state.email.value,
      onChanged: (text) {
        bloc?.add(EmailChanged(email: BlocFormItem(value: text)));
      },
      validator: (value) {
        return state.email.error?.isNotEmpty == true ? state.email.error : null;
      },
      color: Colors.black,
    );
  }

  Widget _imageClient(BuildContext context){
    return GestureDetector(
      onTap: (){
        SelectOptionImageDialog(
          context,
          (){bloc?.add(PickImage());}, 
          (){bloc?.add(TakePhoto());}, 
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(top:100),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child:state.file != null 
              ? Image.file(
                state.file!,
                fit: BoxFit.cover,
                )
              :Image.asset('assets/img/no-image.png',
              fit: BoxFit.cover),
              ),
            ),
        ),
    );
  }

  Widget _imageBackground(BuildContext context){
    return Image.asset(
      'assets/img/background.jpg',
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Color.fromRGBO(0,0,0,0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}