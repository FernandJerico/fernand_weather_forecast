import 'package:bloc/bloc.dart';
import 'package:fernand_weather_forecast/data/models/response/get_detail_weather_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/weather_remote_datasource.dart';

part 'get_detail_weather_state.dart';
part 'get_detail_weather_cubit.freezed.dart';

class GetDetailWeatherCubit extends Cubit<GetDetailWeatherState> {
  final WeatherRemoteDatasource _weatherRemoteDatasource;
  GetDetailWeatherCubit(this._weatherRemoteDatasource)
      : super(const GetDetailWeatherState.initial());

  getDetailWeather(double latitude, double longitude) async {
    emit(const GetDetailWeatherState.loading());

    final response =
        await _weatherRemoteDatasource.getDetailWeather(latitude, longitude);
    response.fold(
      (l) => emit(GetDetailWeatherState.error(l)),
      (r) => emit(GetDetailWeatherState.loaded(r)),
    );
  }

  getDetailWeatherByName(String cityName) async {
    emit(const GetDetailWeatherState.loading());

    final response =
        await _weatherRemoteDatasource.getDetailWeatherByName(cityName);
    response.fold(
      (l) => emit(GetDetailWeatherState.error(l)),
      (r) => emit(GetDetailWeatherState.loaded(r)),
    );
  }
}
