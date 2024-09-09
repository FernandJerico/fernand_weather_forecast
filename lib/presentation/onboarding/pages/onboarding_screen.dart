import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                Text('Never get caught\nin the rain again',
                    style: GoogleFonts.overpass(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray)),
                const SizedBox(height: 8),
                Text('Stay ahead of the weather with our accurate\nforecasts',
                    style: GoogleFonts.overpass(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {},
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
