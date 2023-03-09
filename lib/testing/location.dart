import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _url = 'https://github.com/datsabahandude';
  String lat = '';
  String long = '';
  String locationMessage = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _liveLocation(); // fetch current location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Location'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(locationMessage),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });

                        _getCurrentLocation().then((value) {
                          lat = '${value.latitude}';
                          long = '${value.longitude}';
                          setState(() {
                            locationMessage =
                                'Latitude: $lat\nLongitude: $long';
                            isLoading = false;
                          });
                          // _liveLocation();
                        });
                      },
                      child: const Text('Get Current Location'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: lat.isEmpty
                            ? () {}
                            : () {
                                _openMap(lat, long);
                              },
                        child: const Text('Open Map')),
                    ElevatedButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      child: const Text('My Github Profile'),
                    )
                  ]),
            ),
    );
  }

  /// Permission to use GPS
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Service Disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission Denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permission Permanently Disabled, Please Enable');
    }
    return await Geolocator.getCurrentPosition(); // Fetch Current Position
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {
        locationMessage = 'Latitude: $lat\nLongitude: $long';
      });
    });
  }

  /// Open current location in Google Map
  Future<void> _openMap(String lat, String long) async {
    // refer: https://developers.google.com/maps/documentation/urls/get-started
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw 'Could Not Launch $googleUrl';
  }

  /// Github Profile
  Future<void> _launchUrl() async {
    if (!await launchUrlString(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
