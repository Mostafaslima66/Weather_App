class WeatherModel {
  final String cityName;
  final DateTime Date;
  final String image;
  final double Temp;
  final double maxTemp;
  final double minTemp;
  final String weathercondtion;

  WeatherModel(
      {required this.cityName,
      required this.Date,
      required this.image,
      required this.Temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weathercondtion});

  factory WeatherModel.fromjson(json) {
    return WeatherModel(
        
        cityName:json['location']['name'] ,
        image: json['forecast']['forecastday'][0] ['day']['condition']['icon'],
        Date:DateTime.parse(json['current']['last_updated']) ,
        Temp:json['forecast']['forecastday'][0] ['day']['avgtemp_c'],
        maxTemp:json['forecast']['forecastday'][0] ['day']['maxtemp_c'] ,
        minTemp:json['forecast']['forecastday'][0] ['day']['mintemp_c'],
        weathercondtion:json['forecast']['forecastday'][0] ['hour'][0]['condition']['text'] );
  }
}
