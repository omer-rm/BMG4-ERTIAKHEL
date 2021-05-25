import 'dart:async';

import 'package:Artizakel/configs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTapedScreen extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.015137, 28.979530),
    zoom: 14.4746,
  );
  @override
  _MapTapedScreenState createState() => _MapTapedScreenState();
}

class _MapTapedScreenState extends State<MapTapedScreen> {
  Completer<GoogleMapController> _controllergoogleMap = Completer();
  GoogleMapController newGooglemapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: MapTapedScreen._kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controllergoogleMap.complete(controller);
            newGooglemapController = controller;

            locatePosition();
          },
        ),
      ],
    );
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPos = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGooglemapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
