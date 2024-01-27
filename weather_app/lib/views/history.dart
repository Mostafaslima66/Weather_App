import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  _SearchHistoryPageState createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  List<String> HISTORY = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
    HISTORY = prefs.getStringList('searchHistory') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search History'),
      ),
      body: ListView.builder(
        itemCount:HISTORYy.length,
        itemBuilder: (context, index) {
          return ListTile(
            
            title: Text(HISTORYy[index]),
            onTap: () async {  
                var getweathercubit = BlocProvider.of<GetWeatherCubit>(context);
                getweathercubit.getWeather(
                    value:HISTORYy[index]);
              
              Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) {
                      return WeatherInfoBody()
                  ;
                }));
            },
          );
        },
      ),
    );
  }
}
