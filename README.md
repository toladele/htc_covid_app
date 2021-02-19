# CovidWatch
The COVID-19 pandemic has changed the way we work and live. CovidWatch is designed to make Canadian lives easier during these difficult times. 
View detailed, live statistics of confirmed cases, explore a heat map to see the most dangerous regions to contract the virus, and make an appointment to get vaccinated at the nearest health clinic to you. 

## Competition
Built for the University of Toronto's Hack the Case hackathon/case competition.

## Technology
CovidWatch is built entirely with Flutter, Google's cross-platform mobile application development framework. Data is sourced from Dart's COVID19 package and location features are powered by Google's Maps and Places API.

## Usage
To export and run on your device, view [Flutter's documentation](https://flutter.dev/docs) for more information.
To run on an emulator, open the Flutter project in Android Studio or XCode and add your Google Maps and Places API key to the following locations:
* htc_covid_app/ios/Runner/AppDelegate.swift
* htc_covid_app/android/app/src/main/AndroidManifest.xml
* htc_covid_app/lib/config/key_resource.dart