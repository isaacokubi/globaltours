import 'package:dio/dio.dart';

class ApiError {
  const ApiError(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiError.from(Object error) {
    if (error is DioException) {
      final status = error.response?.statusCode;
      final data = error.response?.data;

      if (data is Map) {
        final message = data['message'] ?? data['error'];
        if (message != null && message.toString().trim().isNotEmpty) {
          return ApiError(message.toString(), statusCode: status);
        }
      }

      if (status == 401) {
        return const ApiError(
          'Your session has expired. Please sign in again.',
          statusCode: 401,
        );
      }
      if (status == 403) {
        return const ApiError(
          'You do not have permission to perform this action.',
          statusCode: 403,
        );
      }
      if (status == 404) {
        return const ApiError(
          'The requested resource was not found.',
          statusCode: 404,
        );
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return const ApiError('The server took too long to respond.');
      }
      if (error.type == DioExceptionType.connectionError) {
        return const ApiError(
          'Unable to connect to the Global Tours server.',
        );
      }
    }

    return ApiError(error.toString());
  }
}
