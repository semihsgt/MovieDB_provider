import 'package:dio/dio.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';
import 'package:moviedb_org/models/movies_model.dart';

class NetworkManager {
  late Dio _dio;
  static NetworkManager? _instance;

  NetworkManager._() {
    configureDio();
  }

  static NetworkManager get instance {
    if (_instance == null) {
      _instance = NetworkManager._();
      return _instance!;
    }

    return _instance!;
  }

  configureDio() {
    final option = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: ApiConstants.headers,
    );

    _dio = Dio(option);
  }

  Future<T?> getRequest<T extends BaseModel>(
    String endpoint, {
    Map<String, dynamic>? queryParam,
    required T model,
  }) async {
    try {
      final result = await _dio.get(endpoint, queryParameters: queryParam);
      return model.fromJson(result.data);
    } catch (e) {
      return null;
    }
  }

  Future<T?> postRequest<T extends BaseModel>(
    String endpoint, {
    Map<String, dynamic>? queryParam,
    T? model,
    required Map<String, dynamic> body,
  }) async {
    try {
      final result = await _dio.post(
        endpoint,
        queryParameters: queryParam,
        data: body,
      );
      return model?.fromJson(result.data);
    } catch (e) {
      return null;
    }
  }
}
