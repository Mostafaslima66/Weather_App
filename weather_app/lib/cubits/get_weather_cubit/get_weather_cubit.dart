import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Models/WeatherModel.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/services/Weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherStates> {
  GetWeatherCubit() : super(NoWeatherState());
   WeatherModel? weatherModel;

  getWeather({required String value}) async {
    try {
      emit(LoadingState());
      weatherModel =
          await WeatherService(Dio()).getCurrentWeather(cityName: value);

      emit(WeatherloadedState());
    } catch(e) {
      emit(FailureState());
    }
  }
}
