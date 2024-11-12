import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterBloc.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterEvent.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';
import 'package:tots_test/src/presentation/widgets/DefaultButton.dart';
import 'package:tots_test/src/presentation/widgets/DefaultIconBack.dart';
import 'package:tots_test/src/presentation/widgets/Default_textfield.dart';

class Registercontent extends StatelessWidget {
  
  RegisterBloc? bloc;
  RegisterState state;
  final GlobalKey<FormState> formKey;

  Registercontent(this.bloc, this.state,this.formKey);

  @override
  Widget build(BuildContext context) {
    return Form(
      key:  formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DefaultIconBack(
            left: 1,
            top: 20
            ),
          Container(
            height: MediaQuery.of(context).size.height* 0.75,
            width: MediaQuery.of(context).size.width * 0.85,  
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.3),
              borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _image1(),
                  _iconPerson(),
                  _textRegister(),
                  _textFieldFirstName(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _textFieldConfirmPassword(),
                  _buttonRegister(context)                  
                ],
              ),
            ),            
          )
        ],
      ),
    );     
  }

  Widget _image1(){
    return Image.asset(
    'assets/img/image.png', 
    width: 282, 
    height: 118.12,
    fit: BoxFit.cover, 
  );
  }
  
  Widget _iconPerson(){
    return const Icon(
      Icons.person,
      color: Colors.grey,
      size: 125,  
    );
  }

  Widget _textRegister(){
    return const Text(
      'Register',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _textFieldFirstName(){
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: DefaultTextfield(
        label: 'First name',
        errorText: state.showErrors ? state.firstName.error : null,
        onChanged: (text){
          bloc?.add(RegisterFirstNameChanged(firstName: BlocFormItem(value: text)));
        }),
    );
  }


  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: DefaultTextfield(
        label: 'Email',
        errorText: state.showErrors ? state.email.error : null,
        onChanged: (text){
          bloc?.add(RegisterEmailChanged(email: BlocFormItem(value: text)));
        }),
    );
  }


  Widget _textFieldPassword(){
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: DefaultTextfield(
        obscureText: false,
        label: 'Password',
        errorText: state.showErrors ? state.password.error : null,
        onChanged: (text){
          bloc?.add(RegisterPasswordChanged(password: BlocFormItem(value: text)));
        }),
    );
  }

  Widget _textFieldConfirmPassword(){
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: DefaultTextfield(
        obscureText: false,
        label: 'Confirm password',
        errorText: state.showErrors ? state.confirmPassword.error : null,
        onChanged: (text){
          bloc?.add(RegisterConfirmPasswordChanged(confirmPassword: BlocFormItem(value: text)));
        }),
    );
  }

  Widget _buttonRegister(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 25, right: 25, top: 25),
    child: Defaultbutton(
      text: 'REGISTER',
      color: Colors.black,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          bloc?.add(RegisterFormSubmit());
        } else {
          Fluttertoast.showToast(
            msg: 'The form is invalid',
            toastLength: Toast.LENGTH_LONG,
          );
        }
      },
    ),
  );
}


}
