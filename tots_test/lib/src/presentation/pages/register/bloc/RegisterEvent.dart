
import 'package:equatable/equatable.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();
  @override
  List<Object?> get props =>[];
}

class RegisterInitEvent extends RegisterEvent{
  const RegisterInitEvent();
}
class RegisterEmailChanged extends RegisterEvent{
  final BlocFormItem email;
  const RegisterEmailChanged({required this.email} );

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent{
  final BlocFormItem password;
  const RegisterPasswordChanged({required this.password} );

  @override
  List<Object?> get props => [password];
}

class RegisterFirstNameChanged extends RegisterEvent{
  final BlocFormItem firstName;
  const RegisterFirstNameChanged({required this.firstName} );

  @override
  List<Object?> get props => [firstName];
}

class RegisterConfirmPasswordChanged extends RegisterEvent{
  final BlocFormItem confirmPassword;
  const RegisterConfirmPasswordChanged({required this.confirmPassword} );

  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterFormSubmit extends RegisterEvent{
  const RegisterFormSubmit();
}

class RegisterFormReset extends RegisterEvent{
  const RegisterFormReset();
}