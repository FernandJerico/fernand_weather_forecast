import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/weather_remote_datasource.dart';
import '../../../../data/models/response/get_weather_response_model.dart';

part 'get_weather_state.dart';
part 'get_weather_cubit.freezed.dart';

class GetWeatherCubit extends Cubit<GetWeatherState> {
  final WeatherRemoteDatasource _weatherRemoteDatasource;
  GetWeatherCubit(this._weatherRemoteDatasource)
      : super(const GetWeatherState.initial());

  getWeather(double latitude, double longitude) async {
    emit(const GetWeatherState.loading());
    final response =
        await _weatherRemoteDatasource.getWeather(latitude, longitude);
    response.fold(
      (l) => emit(GetWeatherState.error(l)),
      (r) => emit(GetWeatherState.loaded(r)),
    );
  }
}
