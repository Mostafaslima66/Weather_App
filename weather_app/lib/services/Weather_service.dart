import 'package:dio/dio.dart';
import 'package:weather_app/Models/WeatherModel.dart';

class WeatherService {
  final Dio dio;
  final String baseurl = 'http://api.weatherapi.com/v1';
  final String apikey = '85ee8939690746af891103707241001 ';

  WeatherService(this.dio);

  Future<WeatherModel> getCurrentWeather({required String cityName,
  String? query,String?HISTORYy}) async {
    try {
       
      Response response =
       
          await dio.get('$baseurl/forecast.json?key=$apikey&q=${HISTORYy??query??cityName}&days=1');
      WeatherModel _weatherModel = WeatherModel.fromjson(response.data);
      return _weatherModel;
    }  on DioException catch (e) {
      final String errormessage = e.response?.data['error']['message'] ??
          'oops there was an error try again later';
      throw Exception(errormessage);
    } catch (e) {
      throw Exception('oops there was an error try again later');
    }
  }
}
