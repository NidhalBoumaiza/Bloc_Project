import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'Screens/create_screen/controller/controller_create_screen.dart';
import 'constants.dart';
import 'function_get_location.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final ControllerCreateScreen controllerCreateScreen =
      Get.find<ControllerCreateScreen>();
  // Extract latitude and longitude from the arguments

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? tappedPoint; // Store the tapped point
  // double? latitude;
  // double? longitude;
  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments = Get.arguments;
    controllerCreateScreen.eventLatitude = arguments['lat'];
    controllerCreateScreen.eventLongitude = arguments['long'];
    tappedPoint = LatLng(controllerCreateScreen.eventLatitude!,
        controllerCreateScreen.eventLongitude!); // Set initial tapped point
  }

  dynamic result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(50), // Replace 100 with your desired height
        child: AppBar(
          backgroundColor: AppColor.secondaryColor,
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          backgroundColor: AppColor.secondaryColor,
          onPressed: () async {
            if (result != null) {
              Get.back(result: result);
            } else {
              result = await GetAddressFromLatLong(
                  controllerCreateScreen.eventLatitude,
                  controllerCreateScreen.eventLongitude);
              Get.back(result: result);
            }
          },
          child: Icon(FontAwesomeIcons.check),
        ),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        markers: tappedPoint != null ? _createMarkers() : Set<Marker>(),
        initialCameraPosition: CameraPosition(
          target: LatLng(controllerCreateScreen.eventLatitude!,
              controllerCreateScreen.eventLongitude!),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _handleTap,
      ),
    );
  }

  void _handleTap(LatLng point) async {
    setState(() {
      tappedPoint = point;
    });
    controllerCreateScreen.eventLatitude = point.latitude;
    controllerCreateScreen.eventLongitude = point.longitude;
    result = await GetAddressFromLatLong(
        tappedPoint?.latitude, tappedPoint?.longitude);
  }

  Set<Marker> _createMarkers() {
    return <Marker>{
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint!,
        icon: BitmapDescriptor
            .defaultMarker, // You can also use BitmapDescriptor.fromAsset() for custom icons
      ),
    };
  }

  // void _handleTap(LatLng point) {
  //   print("Tapped on: ${point.latitude}, ${point.longitude}");
  //   // Here you can use the 'point' variable to access the tapped coordinates.
  //   final Marker newMarker = Marker(
  //     markerId: MarkerId(point.toString()),
  //     position: point,
  //     infoWindow: InfoWindow(
  //       title: 'Tapped Point',
  //       snippet: '${point.latitude}, ${point.longitude}',
  //     ),
  //   );
  //
  //   // Add the new marker to the set
  //   setState(() {
  //     markers.add(newMarker);
  //   });
  // }
}
