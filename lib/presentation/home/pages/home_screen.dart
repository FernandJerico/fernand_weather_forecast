import 'dart:ui';

import 'package:fernand_weather_forecast/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 20, top: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image.asset('assets/icons/map.png'),
                              const SizedBox(width: 20),
                              Text(
                                'Semarang',
                                style: GoogleFonts.overpass(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(-2.0, 3.0),
                                      blurRadius: 1.0,
                                      color: Color(0x1A000000),
                                    ),
                                    const Shadow(
                                      offset: Offset(-1.0, 1.0),
                                      blurRadius: 2.0,
                                      color: Color(0x40FFFFFF),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Image.asset('assets/icons/arrow-down.png'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors
                                  .transparent, // Set background transparent
                              builder: (context) {
                                return Stack(
                                  children: [
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        color: const Color(0xff8C8C8C)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    DraggableScrollableSheet(
                                      initialChildSize: 0.5,
                                      maxChildSize: 0.8,
                                      minChildSize: 0.2,
                                      builder: (context, scrollController) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                Center(
                                                  child: Container(
                                                    height: 3,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: AppColors.gray,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  child: Text(
                                                    'Your Notification',
                                                    style: GoogleFonts.overpass(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors.darkBlue,
                                                      shadows: [
                                                        const Shadow(
                                                          offset:
                                                              Offset(-2.0, 3.0),
                                                          blurRadius: 1.0,
                                                          color:
                                                              Color(0x1A000000),
                                                        ),
                                                        const Shadow(
                                                          offset:
                                                              Offset(-1.0, 1.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0x40FFFFFF),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  child: Text(
                                                    'New',
                                                    style: GoogleFonts.overpass(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.darkBlue),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: ExpansionTile(
                                                      backgroundColor:
                                                          const Color(
                                                                  0xff95E5FF)
                                                              .withOpacity(
                                                                  0.28),
                                                      leading: const Icon(
                                                        Icons.sunny,
                                                        color:
                                                            AppColors.darkBlue,
                                                      ),
                                                      subtitle: Text(
                                                        'A sunny day in your location, consider wearing your UV protection',
                                                        style: GoogleFonts
                                                            .overpass(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: AppColors
                                                                    .darkBlue),
                                                      ),
                                                      title: Text(
                                                        '10 minutes ago',
                                                        style: GoogleFonts
                                                            .overpass(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: AppColors
                                                                    .darkBlue),
                                                      ),
                                                      children: const [
                                                        Text(
                                                            'This is the content'),
                                                      ]),
                                                ),
                                                const SizedBox(height: 16),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  child: Text(
                                                    'Earlier',
                                                    style: GoogleFonts.overpass(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.darkBlue),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: ExpansionTile(
                                                      leading: const Icon(
                                                        Icons.air,
                                                        color: Color.fromRGBO(
                                                            68, 78, 114, 1),
                                                      ),
                                                      subtitle: Text(
                                                        'A cloudy day will occur all day long, don\'t worry about the heat of the sun',
                                                        style: GoogleFonts
                                                            .overpass(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: AppColors
                                                                    .darkBlue),
                                                      ),
                                                      title: Text(
                                                        '1 hour ago',
                                                        style: GoogleFonts
                                                            .overpass(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: AppColors
                                                                    .darkBlue),
                                                      ),
                                                      children: const [
                                                        Text(
                                                            'This is the content'),
                                                      ]),
                                                ),
                                                const SizedBox(height: 8),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: ExpansionTile(
                                                      leading: const Icon(
                                                        Icons.cloud,
                                                        color: Color.fromRGBO(
                                                            68, 78, 114, 1),
                                                      ),
                                                      subtitle: Text(
                                                        'A cloudy day in your location, consider wearing your UV protection',
                                                        style: GoogleFonts
                                                            .overpass(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: AppColors
                                                                    .darkBlue),
                                                      ),
                                                      title: Text(
                                                        '1 hour ago',
                                                        style: GoogleFonts
                                                            .overpass(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: AppColors
                                                                    .darkBlue),
                                                      ),
                                                      children: const [
                                                        Text(
                                                            'This is the content'),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Image.asset('assets/icons/notification.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Image.asset('assets/images/cloudy.png'),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffBFBFBF).withOpacity(0.7)),
                      child: Column(
                        children: [
                          const TextShadow(
                            title: 'Today, 12 September',
                            fontSize: 18,
                          ),
                          const TextShadow(
                            title: '29 °',
                            fontSize: 100,
                          ),
                          const TextShadow(
                            title: 'Cloudy',
                            fontSize: 24,
                          ),
                          Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FixedColumnWidth(60),
                              2: IntrinsicColumnWidth(),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/wind.png'),
                                      const SizedBox(width: 10),
                                      const TextShadow(
                                          title: 'Wind', fontSize: 18)
                                    ],
                                  ),
                                  Text(
                                    '|',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const TextShadow(
                                      title: '10 km/h', fontSize: 18)
                                ],
                              ),
                              TableRow(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/hum.png'),
                                      const SizedBox(width: 10),
                                      const TextShadow(
                                          title: 'Hum', fontSize: 18)
                                    ],
                                  ),
                                  Text(
                                    '|',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const TextShadow(title: '54 %', fontSize: 18)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                left: 80,
                right: 80,
                bottom: 40,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Weather Details',
                        style: GoogleFonts.overpass(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkBlue),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.darkBlue,
                        size: 18,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class TextShadow extends StatelessWidget {
  final String title;
  final double fontSize;
  const TextShadow({
    super.key,
    required this.title,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.overpass(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        shadows: [
          const Shadow(
            offset: Offset(-2.0, 3.0),
            blurRadius: 1.0,
            color: Color(0x1A000000),
          ),
          const Shadow(
            offset: Offset(-1.0, 1.0),
            blurRadius: 2.0,
            color: Color(0x40FFFFFF),
          ),
        ],
      ),
    );
  }
}
