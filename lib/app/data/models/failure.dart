abstract class Failure {
  final String message;

  Failure({required this.message});
}

class HttpFailure implements Failure {
  final int? code;

  HttpFailure({required this.code});

  @override
  String get message => 'Erro HTTP $code';
}

class TimeoutFailure implements Failure {
  @override
  String get message => 'Tempo excedido';
}

class NoConnectionFailure implements Failure {
  @override
  String get message => 'Erro de conexão';
}

class UnknownFailure implements Failure {
  @override
  String get message => 'Erro desconhecido';
}
