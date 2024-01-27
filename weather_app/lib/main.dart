import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              // theme: ThemeData.dark(),
              theme: ThemeData(
                primarySwatch: getWeatherColor(
                  BlocProvider.of<GetWeatherCubit>(context)
                      .weatherModel?.weathercondtion
                ),
                useMaterial3: false,
              ),
              home: HomeView(),
            );
          },
        ),
      ),
    );
  }
}

MaterialColor getWeatherColor(String? weatherDescription) {
  if (weatherDescription == null) {
    return Colors.blue;
  } else {
    switch (weatherDescription) {
       case "Sunny":
        
        return Colors.amber;
       case "Partly cloudy":
        case "Thundery outbreaks possible":
        case "Blowing snow":
        case "Blizzard":
        case "Ice pellets":
        case "Light rain shower":
        case "Moderate or heavy rain shower":
        case "Torrential rain shower":
        case "Light sleet showers":
        case "Moderate or heavy sleet showers":
        case "Light snow showers":
        case "Moderate or heavy snow showers":
        case "Light showers of ice pellets":
        case "Moderate or heavy showers of ice pellets":
        case "Cloudy":
        case "Overcast":
        case "Mist":
        case "Fog":
        case "Freezing fog":
        case "Patchy rain possible":
        case "Patchy snow possible":
        case "Patchy sleet possible":
        case "Patchy freezing drizzle possible":
        case "Patchy light snow":
        case "Light snow":
        case "Patchy moderate snow":
        case "Moderate snow":
        case "Patchy heavy snow":
        case "Heavy snow":
            return Colors.grey;
        case "Patchy light drizzle":
        case "Light drizzle":
        case "Freezing drizzle":
        case "Heavy freezing drizzle":
        case "Patchy light rain":
        case "Light rain":
        case "Moderate rain at times":
        case "Moderate rain":
        case "Heavy rain at times":
        case "Heavy rain":
        case "Light freezing rain":
        case "Moderate or heavy freezing rain":
        case "Light sleet":
        case "Moderate or heavy sleet":
        case "Patchy light rain with thunder":
        case "Moderate or heavy rain with thunder":
        case "Patchy light snow with thunder":
        case "Moderate or heavy snow with thunder":
        case "Clear":
            return Colors.lightBlue;
       
      default:
        return Colors.blue;
    }
  }
}
