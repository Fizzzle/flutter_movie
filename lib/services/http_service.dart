import '../models/app_config.dart';

//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _base_url;
  late String _api_key;

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  Future<Response> get(String _path,
      {required Map<String, dynamic> query}) async {
    try {
      String _url = '$_base_url$_path';
      Map<String, dynamic> _query = {
        'api_key': _api_key,
        'language': 'ru-RU',
      };
      if (_query != null) {
        _query.addAll(_query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print('Error');
      print('DioError:$e');
      throw FormatException('Expected at least 1 section');
    }
  }
}
