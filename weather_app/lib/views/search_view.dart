

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
