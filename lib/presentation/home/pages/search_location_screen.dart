// ignore_for_file: unused_field

import 'dart:convert';

import 'package:fernand_weather_forecast/presentation/home/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constant/colors.dart';
import 'package:http/http.dart' as http;

class SearchLocationScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  const SearchLocationScreen({super.key, this.latitude, this.longitude});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController searchController = TextEditingController();
  late GoogleMapController _mapController;
  LatLng? _lastTappedLatLng;
  final Set<Marker> _markers = {};

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
      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;

        if (latitude != null && longitude != null) {
          _markers.add(
            Marker(
              markerId: const MarkerId("current_location"),
              position: LatLng(latitude!, longitude!),
              infoWindow: const InfoWindow(
                title: 'Current Location',
              ),
              onTap: () {
                _showCoordinatesDialog(LatLng(latitude!, longitude!));
              },
            ),
          );
        }
      });
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

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    if (widget.latitude != null && widget.longitude != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("initial_marker"),
          position: LatLng(widget.latitude!, widget.longitude!),
          infoWindow: const InfoWindow(
            title: 'Current Location',
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            _showCoordinatesDialog(LatLng(widget.latitude!, widget.longitude!));
          },
        ),
      );
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
    LatLng initialCameraPosition = LatLng(
      widget.latitude ?? latitude ?? 0,
      widget.longitude ?? longitude ?? 0,
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              child: (latitude == null && widget.latitude == null)
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: initialCameraPosition,
                        zoom: 18.0,
                      ),
                      markers: _markers,
                      onTap: (LatLng latLng) {
                        setState(() {
                          _lastTappedLatLng = latLng;

                          _markers.add(
                            Marker(
                              markerId: MarkerId(latLng.toString()),
                              position: latLng,
                              infoWindow: InfoWindow(
                                title:
                                    'Lat: ${latLng.latitude}, Lng: ${latLng.longitude}',
                              ),
                              icon: BitmapDescriptor.defaultMarker,
                            ),
                          );
                        });

                        _showCoordinatesDialog(latLng);
                      },
                    ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 32, left: 16, right: 16, bottom: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gray.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                              Icons.arrow_back_rounded),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            onFieldSubmitted: (value) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(
                                                      cityName:
                                                          searchController.text,
                                                    ),
                                                  ));
                                            },
                                            controller: searchController,
                                            decoration: InputDecoration(
                                              hintText: 'Search here',
                                              border: InputBorder.none,
                                              hintStyle: GoogleFonts.overpass(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.gray),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.mic),
                                  ),
                                ],
                              )),
                          const SizedBox(height: 32),
                          Text(
                            'Recent search',
                            style: GoogleFonts.overpass(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkBlue),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: const Text("Yogyakarta"),
                                    leading:
                                        const Icon(Icons.watch_later_outlined),
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return const HomeScreen(
                                            cityName: 'Yogyakarta',
                                          );
                                        },
                                      ));
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                                itemCount: 1),
                          ),
                        ],
                      )),
                )),
          ],
        ),
      ),
    );
  }

  void _showCoordinatesDialog(LatLng latLng) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coordinates'),
        content: Text('Lat: ${latLng.latitude}\nLng: ${latLng.longitude}'),
        actions: [
          TextButton(
            onPressed: () async {
              final cityName =
                  await getPlaceName(latLng.latitude, latLng.longitude);
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen(
                      cityName: cityName,
                      latitude: latLng.latitude,
                      longitude: latLng.longitude,
                    );
                  },
                ));
              }
            },
            child: const Text('Show Weather'),
          ),
        ],
      ),
    );
  }
}
