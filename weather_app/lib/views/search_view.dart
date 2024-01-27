

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/widgets/countres.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

class searchview extends StatelessWidget {
  const searchview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CitySearch());
              },
              icon: const Icon(Icons.search))
        ],
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Search a City'),
      ),
      /*** 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return countriesList.where((countryName) {
                  return countryName.contains(textEditingValue.text);
                });
              },
              
              onSelected: (countryName) async {
                var getweathercubit = BlocProvider.of<GetWeatherCubit>(context);
                getweathercubit.getWeather(value: countryName);
                
                // WeatherModel weatherModel = await WeatherService(Dio())
                //   .getCurrentWeather(cityName: value);
                Navigator.pop(context);
              },
              
              /*** 
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              suffixIcon: const Icon(Icons.search),
              suffixIconColor: Colors.black,
              hintText: 'Enter City Name',
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
            ***/
             // ),
       // ),
      //),
      ***/
    );
  }
}

class CitySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return WeatherInfoBody();
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List filterlist = countriesList
        .where(
          (countryName) => countryName.startsWith(query),
        )
        .toList();

    return ListView.builder(
        itemCount: query == '' ? null : filterlist.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () async {
              showResults(context);
              if (i < filterlist.length) {
                showResults(context);
                HISTORYy.add(filterlist[i]);
                showResults(context);
                var getweathercubit = BlocProvider.of<GetWeatherCubit>(context);
                getweathercubit.getWeather(
                    value: filterlist.isEmpty ? query : filterlist[i]);

              }
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: query == '' || i >= filterlist.length
                    ? null
                    : Text(
                        "${filterlist[i]}",
                        style: const TextStyle(fontSize: 22),
                      ),
              ),
            ),
          );
        });
  }
}

List<String> HISTORYy = [];
