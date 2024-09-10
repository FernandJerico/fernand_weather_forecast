import 'package:fernand_weather_forecast/presentation/home/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constant/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_lastTappedLatLng != null) {
            _mapController.animateCamera(
              CameraUpdate.newLatLng(_lastTappedLatLng!),
            );
          }
        },
        child: const Icon(Icons.location_searching),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              child: widget.latitude == null
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
                        target: LatLng(widget.latitude!, widget.longitude!),
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
                                  return InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      title: Text("Search $index"),
                                      leading: const Icon(
                                          Icons.watch_later_outlined),
                                      onTap: () {},
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                                itemCount: 3),
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
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(
                    latitude: latLng.latitude,
                    longitude: latLng.longitude,
                  );
                },
              ));
            },
            child: const Text('Show Weather'),
          ),
        ],
      ),
    );
  }
}
