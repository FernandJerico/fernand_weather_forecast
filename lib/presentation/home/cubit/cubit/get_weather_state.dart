part of 'get_weather_cubit.dart';

@freezed
class GetWeatherState with _$GetWeatherState {
  const factory GetWeatherState.initial() = _Initial;
  const factory GetWeatherState.loading() = _Loading;
  const factory GetWeatherState.loaded(
      GetWeatherResponseModel getWeatherResponseModel) = _Loaded;
  const factory GetWeatherState.error(String message) = _Error;
}
