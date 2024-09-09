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
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    LatLng center = LatLng(widget.latitude ?? 0, widget.longitude ?? 0);
    Marker marker = Marker(
      markerId: const MarkerId("marker_1"),
      position: LatLng(widget.latitude ?? 0, widget.longitude ?? 0),
    );
    return Scaffold(
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
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: center,
                        zoom: 18.0,
                      ),
                      markers: {marker},
                    ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
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
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_rounded)),
                                    Text(
                                      "Search here",
                                      style: GoogleFonts.overpass(
                                        color: AppColors.gray,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.mic)),
                              ],
                            ),
                          ),
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
                            height: 200,
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
}
