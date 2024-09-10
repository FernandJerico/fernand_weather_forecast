import 'package:fernand_weather_forecast/presentation/home/widgets/text_shadow.dart';
import 'package:flutter/material.dart';

class DetailWeatherScreen extends StatefulWidget {
  const DetailWeatherScreen({super.key});

  @override
  State<DetailWeatherScreen> createState() => _DetailWeatherScreenState();
}

class _DetailWeatherScreenState extends State<DetailWeatherScreen> {
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
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextShadow(
                          title: 'Today',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                        TextShadow(
                          title: 'Sep, 12',
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
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 70,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextShadow(title: '29°C', fontSize: 18),
                                  Image.asset('assets/images/cloudy.png'),
                                  const TextShadow(
                                      title: '15.00', fontSize: 18),
                                ],
                              ));
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
                        child: RawScrollbar(
                          thumbColor: Colors.white,
                          trackColor: Colors.white.withOpacity(0.25),
                          interactive: true,
                          thickness: 6,
                          trackVisibility: true,
                          thumbVisibility: true,
                          radius: const Radius.circular(10),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 48),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextShadow(
                                        title: 'Sep, 13',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      Image.asset(
                                        'assets/images/cloudy.png',
                                        height: 50,
                                      ),
                                      const TextShadow(
                                        title: '29°C',
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
                              itemCount: 7),
                        ),
                      )),
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
