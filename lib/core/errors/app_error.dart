abstract class AppError {
  final String message;
  final String? technicalDetails;

  AppError(this.message, {this.technicalDetails});

  String get userMessage => message;
}

class NetworkError extends AppError {
  NetworkError({String? details})
    : super(
        'sem conexão. verifique sua internet.',
        technicalDetails: details,
      );
}

class ServerError extends AppError {
  ServerError({String? details})
    : super(
        'servidor fora do ar. tente novamente.',
        technicalDetails: details,
      );
}

class DataParsingError extends AppError {
  DataParsingError({String? details})
    : super(
        'erro ao processar dados. tente novamente.',
        technicalDetails: details,
      );
}

class UnknownError extends AppError {
  UnknownError({String? details})
    : super(
        'algo deu errado. tente novamente.',
        technicalDetails: details,
      );
}
