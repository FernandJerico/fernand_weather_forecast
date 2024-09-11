part of 'get_detail_weather_cubit.dart';

@freezed
class GetDetailWeatherState with _$GetDetailWeatherState {
  const factory GetDetailWeatherState.initial() = _Initial;
  const factory GetDetailWeatherState.loading() = _Loading;
  const factory GetDetailWeatherState.loaded(
    GetDetailWeatherResponseModel detailWeather,
  ) = _Loaded;
  const factory GetDetailWeatherState.error(String message) = _Error;
}
