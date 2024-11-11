import 'package:equatable/equatable.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';

class ClientState extends Equatable {
  final Resource? response;

  const ClientState({this.response});

  ClientState copyWith({
    Resource? response,
  }) {
    return ClientState(
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [response];
}

