import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../utils/color_constant.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(31.460568, 74.242035),
    zoom: 15.r,
  );

  final List<LatLng> _latLen = <LatLng>[
    LatLng(31.458800, 74.242158),
    LatLng(31.460568, 74.242035),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  Future<void> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    Uint8List markerIcon = (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!
        .buffer
        .asUint8List();

    _markers.clear();
    for (int i = 0; i < _latLen.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: _latLen[i],
          infoWindow: InfoWindow(
            title: 'Location',
          ),
        ),
      );
    }

    setState(() {});
  }

  loadData() async {
    await checkLocationPermission();
    if (_permissionGranted != PermissionStatus.granted || _locationData == null) {
      return;
    }

    await getImages('assets/images/pin.png', 100);
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionGranted == PermissionStatus.denied || !_serviceEnabled) {
      return Scaffold(
        body: Center(
          child: Text(
            _serviceEnabled
                ? 'Location permission denied. Please grant permission.'
                : 'Location service disabled. Please enable location services.',
            style: TextStyle(fontSize: 9.sp),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: ColorConstants.grey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Location",
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorConstants.grey,
          iconTheme: IconThemeData(
            color: ColorConstants.black,
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      );
    }
  }
}
