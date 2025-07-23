import 'package:dio/dio.dart';

abstract class Failers {
  final String erroeMessage;

  Failers(this.erroeMessage);
}

class ServerFailers extends Failers {
  ServerFailers(super.erroeMessage);
  factory ServerFailers.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailers(
          'Connection timeout occurred. Please check your network and try again.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailers(
          'Send timeout occurred. Unable to send the request within the allowed time.',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailers(
          'Receive timeout occurred. The server took too long to respond.',
        );

      case DioExceptionType.badCertificate:
        return ServerFailers(
          'Bad certificate error. There may be an issue with the SSL certificate.',
        );
      case DioExceptionType.badResponse:
        return ServerFailers.fromRespons(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailers('Request was cancelled. Please try again.');
      case DioExceptionType.connectionError:
        return ServerFailers(
          'Connection error. Unable to establish a connection with the server.',
        );
      case DioExceptionType.unknown:
        return ServerFailers('ther was an error , pleasetry a gain');
    }
  }
  factory ServerFailers.fromRespons(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailers(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailers(
        'Not Found: The requested resource could not be found on the server.',
      );
    } else if (statusCode == 500) {
      return ServerFailers(
        'Internal Server Error: Something went wrong on the server. Please try again later.',
      );
    } else if (statusCode == 503) {
      return ServerFailers(
        'Service Unavailable: The server is temporarily unavailable. Please try again later.',
      );
    } else {
      return ServerFailers(
        'Unexpected Error: An unexpected error occurred. Status code:$statusCode',
      );
      // 'Unexpected Error: An unexpected error occurred. Status code: $statusCode');
    }
  }
}
