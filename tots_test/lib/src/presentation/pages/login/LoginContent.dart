import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginBloc.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginEvent.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';
import 'package:tots_test/src/presentation/widgets/Default_textfield.dart';

//DISEÑO DE LOGIN
class Logincontent extends StatefulWidget {

  LoginBloc? bloc;
  LoginState state;
  Logincontent(
    this.bloc,
    this.state
  );

  @override
  State<Logincontent> createState() => _LogincontentState();
}

class _LogincontentState extends State<Logincontent> {

  bool _obscurePassword = true;

  void _toggleObscureText() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          //_imageBackground(context),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.75,          
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,//VERTICAL
                crossAxisAlignment: CrossAxisAlignment.center,//HORIZONTAL
                children: [
                  _image1(),
                  _textLogin(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(context),
                  _textDontHaveAccount(),
                  _buttonGoToRegister(context)                                   
                ],
              ),
            ),
          ),
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

  Widget _textLogin(){
    return const Text(
      'LOG IN',
        style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(13, 17, 17, 0.85)
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        child: DefaultTextfield(
          label: 'Email',
          onChanged: (text){
            widget.bloc?.add(EmailChanged(email: BlocFormItem(value: text)));
          },
          validator: (value){
            return widget.state.email.error;
          },
        )
    );
  }

   Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: DefaultTextfield(
        label: 'Password',
        onChanged: (text) {
          widget.bloc?.add(PasswordChanged(password: BlocFormItem(value: text)));
        },
        obscureText: _obscurePassword,
        onToggleObscure: _toggleObscureText,
        validator: (value) {
          return widget.state.password.error;
        },
        showEyeIcon: true,
      ),
    );
  }

  Widget _buttonLogin(BuildContext context){
    return Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
        child: ElevatedButton(
          onPressed:(){
            if(widget.state.formKey!.currentState!.validate()){
              widget.bloc?.add(LoginSubmit());
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
              'LOG IN',
              style: TextStyle(
              color: Colors.white
              ),
            ),
          )
    );
  }

  Widget _textDontHaveAccount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          width: 65,
          height: 1,
          color: Colors.white,
          margin: EdgeInsets.only(right: 5, bottom: 10),
        ),
        const Text(
          'Create an account',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 17
          ),
          ),
        Container(
          width: 65,
          height: 1,
          color: Colors.white,
          margin: EdgeInsets.only(left: 5),
        ),
        ],
      );
  }

  Widget _buttonGoToRegister(BuildContext context){
    return Container(
        height: 55,
        width: MediaQuery.of(context).size.width,//ocupada todo el espacio horizontal
        margin: EdgeInsets.only(left: 25, right: 25, top: 5),
          child: ElevatedButton(
          onPressed:(){
            Navigator.pushNamed(context, 'register');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black
          ),
          child: Text(
            'REGISTER',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }
}



