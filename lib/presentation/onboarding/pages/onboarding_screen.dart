import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

import '../../../core/constant/colors.dart';
import '../../home/pages/home_screen.dart';
import 'package:http/http.dart' as http;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentPosition();
    });
  }

  double? latitude;
  double? longitude;

  Future<void> getCurrentPosition() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;

      setState(() {});
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        debugPrint(
            'A network error occurred trying to lookup the supplied coordinates: ${e.message}');
      } else {
        debugPrint('Failed to lookup coordinates: ${e.message}');
      }
    } catch (e) {
      debugPrint('An unknown error occurred: $e');
    }
  }

  Future<String?> getPlaceName(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${dotenv.env['API_KEY_MAPS']}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        return data['results'][0]['address_components'][2]['long_name'];
      } else {
        debugPrint('Error: ${data['status']}');
        return null;
      }
    } else {
      debugPrint('Failed to connect to Google Geocoding API');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4A9EF7),
                  Color(0xFFFFFFFF),
                ],
                stops: [0.0, 1.25],
                // transform: GradientRotation(171.86 * 3.1415926535897932 / 180),
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: Image.asset('assets/images/circle-line-onboard.png')),
          Positioned(
            top: 70,
            child: Image.asset('assets/images/sun-onboard.png'),
          ),
          Positioned(
            right: 0,
            bottom: 170,
            child: Image.asset('assets/images/cloud-onboard.png'),
          ),
          Positioned(
            bottom: 150,
            left: 32,
            right: 32,
            child: Column(
              children: [
                Text('Never get caught in the rain again',
                    style: GoogleFonts.overpass(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray)),
                const SizedBox(height: 8),
                Text('Stay ahead of the weather with our accurate forecasts',
                    style: GoogleFonts.overpass(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () async {
                      final cityName = await getPlaceName(
                          latitude ?? -7.059662, longitude ?? 110.439135);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen(
                                cityName: cityName ?? 'Semarang',
                                latitude: latitude ?? -7.059662,
                                longitude: longitude ?? 110.439135,
                              );
                            },
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Get Started',
                        style: GoogleFonts.overpass(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkBlue)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
