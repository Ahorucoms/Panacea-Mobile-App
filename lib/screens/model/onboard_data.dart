import 'package:flutter/material.dart';

class OnBoarding {
  final String title;
  final String text;
  final String text1;

  OnBoarding({
    required this.text1,
    required this.text,
    required this.title,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'PANACEA',
    text: 'Browse nearby HealthCare Services',
    text1: 'Set Location to browse nearby Hospitals and Pharmacies to Order your medics',
  ),
  OnBoarding(
    title: 'PANACEA',
    text: 'Browse Medical Products',
    text1: 'Medicines and other pharmaceutical products on your app with regular discounts',
  ),
  OnBoarding(
    title: 'PANACEA',
    text: 'Online Doctor Consultations ',
    text1: 'Chat with experienced medical\n professionals',

  ),
  OnBoarding(
    title: 'PANACEA',
    // image: 'images/onboarding_image_3.png',
    text: 'Keep track of your medical data',
    text1: '',
  ),
  OnBoarding(
    title: 'PANACEA',
    text: 'PANACEA welcome you to the anonymous gateway to Healthcare services',
    text1: 'Get started'
  ),
];
