import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fernand_weather_forecast/core/constant/variables.dart';
import 'package:fernand_weather_forecast/data/models/response/get_weather_response_model.dart';
import 'package:http/http.dart' as http;

class WeatherRemoteDatasource {
  Future<Either<String, GetWeatherResponseModel>> getWeather(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.tomorrow.io/v4/weather/realtime?location=$latitude,$longitude&apikey=${Variables.apiKeyTomorrow}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Right(GetWeatherResponseModel.fromJson(response.body));
    } else {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Left(message);
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }

  Future<Either<String, GetWeatherResponseModel>> getWeatherByName(
      String cityName) async {
    final url = Uri.parse(
        'https://api.tomorrow.io/v4/weather/realtime?location=$cityName&apikey=${Variables.apiKeyTomorrow}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Right(GetWeatherResponseModel.fromJson(response.body));
    } else {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Left(message);
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }
}
