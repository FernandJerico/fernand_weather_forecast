import 'package:fernand_weather_forecast/presentation/home/widgets/text_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/get_detail_weather/get_detail_weather_cubit.dart';

class DetailWeatherScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final String? cityName;
  const DetailWeatherScreen(
      {super.key, this.latitude, this.longitude, this.cityName});

  @override
  State<DetailWeatherScreen> createState() => _DetailWeatherScreenState();
}

class _DetailWeatherScreenState extends State<DetailWeatherScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      context.read<GetDetailWeatherCubit>().getDetailWeather(
            widget.latitude!,
            widget.longitude!,
          );
    } else if (widget.cityName != null) {
      context.read<GetDetailWeatherCubit>().getDetailWeatherByName(
            widget.cityName!,
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String getWeatherDescription(double weatherCode, DateTime time) {
    final hour = time.hour;

    if (weatherCode == 1000.0 && hour >= 18) {
      return 'assets/images/weather/clear-night.png';
    } else if (weatherCode == 1100.0 && hour >= 18) {
      return 'assets/images/weather/mostly-clear-night.png';
    } else if (weatherCode == 1101.0 && hour >= 18) {
      return 'assets/images/weather/partly-cloudy-night.png';
    } else if (weatherCode == 1102.0 && hour >= 18) {
      return 'assets/images/weather/mostly-cloudy-night.png';
    }
    switch (weatherCode) {
      case 1000.0:
        return 'assets/images/weather/clear.png';
      case 1100.0:
        return 'assets/images/weather/mostly-clear.png';
      case 1101.0:
        return 'assets/images/weather/partly-cloudy.png';
      case 1102.0:
        return 'assets/images/weather/mostly-cloudy.png';
      case 1001.0:
        return 'assets/images/weather/cloudy.png';
      case 1103.0:
        return 'assets/images/weather/mixed-cloudy.png';
      case 2100.0:
        return 'assets/images/weather/light-fog.png';
      case 2001.0:
        return 'assets/images/weather/fog.png';
      case 4000.0:
        return 'assets/images/weather/drizzle.png';
      case 4001.0:
        return 'assets/images/weather/rain.png';
      case 4201.0:
        return 'assets/images/weather/heavy-rain.png';
      case 4200.0:
        return 'assets/images/weather/light-rain.png';
      default:
        return 'assets/images/weather/clear.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF47BFDF),
                    Color(0xFF4A91FF),
                  ],
                  stops: [0.0, 1.25],
                  // transform: GradientRotation(171.86 * 3.1415926535897932 / 180),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              child: Image.asset('assets/images/line-left.png'),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset('assets/images/line-right.png'),
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          TextShadow(
                            title: 'Back',
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: sizes.height * 0.07),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextShadow(
                          title: 'Today',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                        TextShadow(
                          title: DateFormat('MMM, d').format(DateTime.now()),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height * 0.035),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: SizedBox(
                      height: sizes.height * 0.155,
                      child: BlocBuilder<GetDetailWeatherCubit,
                          GetDetailWeatherState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            loaded: (detailWeather) {
                              final today = DateTime.now();

                              final weatherToday = detailWeather
                                  .timelines!.hourly!
                                  .where((data) {
                                return data.time!.year == today.year &&
                                    data.time!.month == today.month &&
                                    data.time!.day == today.day;
                              }).toList();
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 8),
                                itemCount: weatherToday.length,
                                itemBuilder: (context, index) {
                                  final data = weatherToday[index];
                                  return Container(
                                      width: 70,
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextShadow(
                                              title:
                                                  '${data.values!['temperature']!.toStringAsFixed(1)}°C',
                                              fontSize: 18),
                                          Image.asset(
                                            getWeatherDescription(
                                                data.values!['weatherCode']!,
                                                data.time!),
                                            height: 40,
                                          ),
                                          TextShadow(
                                              title: DateFormat('HH:mm')
                                                  .format(data.time!),
                                              fontSize: 18),
                                        ],
                                      ));
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: sizes.height * 0.05),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextShadow(
                          title: 'Next Forecast',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                        Icon(Icons.calendar_today, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height * 0.035),
                  SizedBox(
                    height: sizes.height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: BlocBuilder<GetDetailWeatherCubit,
                          GetDetailWeatherState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            loaded: (detailWeather) {
                              final nextDays =
                                  detailWeather.timelines!.daily!.where((data) {
                                return data.time!.isAfter(DateTime.now());
                              }).toList();
                              return RawScrollbar(
                                controller: _scrollController,
                                thumbColor: Colors.white,
                                trackColor: Colors.white.withOpacity(0.25),
                                interactive: true,
                                thickness: 6,
                                trackVisibility: true,
                                thumbVisibility: true,
                                radius: const Radius.circular(10),
                                child: ListView.separated(
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      final data = nextDays[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 48),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextShadow(
                                              title: DateFormat('MMM, d')
                                                  .format(data.time!),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            Image.asset(
                                              getWeatherDescription(
                                                  data.values!.weatherCodeMax!,
                                                  data.time!),
                                              height: 50,
                                            ),
                                            TextShadow(
                                              title:
                                                  '${data.values!.temperatureMax}°C',
                                              fontSize: 18,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 12,
                                        ),
                                    itemCount: nextDays.length),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sunny, color: Colors.white),
                      SizedBox(width: 8),
                      TextShadow(
                          title: 'Fernand Weather Forecast', fontSize: 18),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
