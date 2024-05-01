import 'package:dio/dio.dart';
import 'package:flutter_pokedex/data/remote/interceptor/dio_logging_interceptor.dart';

class HttpClient {
  final Dio dio = Dio();

  static final HttpClient _httpClient = HttpClient._internal();

  factory HttpClient() {
    return _httpClient;
  }

  // https://github.com/flutterchina/dio/blob/develop/example/lib/queued_interceptor_crsftoken.dart
  // https://gist.github.com/TimurMukhortov/a1c9819e3779015e54bc3964b7d2308a
  HttpClient._internal() {
    dio.interceptors
      ..add(DioLoggingInterceptor())
      ..add(QueuedInterceptorsWrapper(onRequest: (options, handler) async {
        handler.next(options);
      }, onError: (DioException error, handler) async {
        return handler.next(error);
      }));
  }
}
