import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late String lat;
  late String long;
  String locationMessage = '';
  bool isLoading = false;
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
                        });
                      },
                      child: const Text('Get Current Location'),
                    )
                  ]),
            ),
    );
  }

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
    return await Geolocator.getCurrentPosition();
  }
}
