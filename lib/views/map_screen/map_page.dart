import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup/utils/color_constant.dart';
import 'package:login_signup/widgets/custom_button.dart';

class GoogleMaps1 extends StatefulWidget {
  const GoogleMaps1({Key? key}) : super(key: key);

  @override
  _GoogleMaps1State createState() => _GoogleMaps1State();
}

class _GoogleMaps1State extends State<GoogleMaps1> {

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;
  TextEditingController _latController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _longController = TextEditingController();
  LatLng? _selectedLocation;

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(31.460568, 74.242035),
    zoom: 15,
  );

  final List<LatLng> _latLen = <LatLng>[
    LatLng(31.458800, 74.242158),
    LatLng(31.460568, 74.242035),
  ];

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

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

  loadData() async {
    await checkLocationPermission();
    if (_permissionGranted != PermissionStatus.granted || _locationData == null) {
      return;
    }

    for (int i = 0; i < _latLen.length; i++) {
      final Uint8List markIcons = await getImages('assets/images/pin.png', 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(markIcons),
          position: _latLen[i],
          infoWindow: InfoWindow(
            title: 'Location',
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<void> addLocationToFirestore(double latitude, double longitude) async {
    try {

      // Get the current user ID
      //
      // // Get a Firestore instance
      // FirebaseFirestore firestore = FirebaseFirestore.instance;
      //
      // // Define a reference to the collection where you want to add the location
      // CollectionReference locations = firestore.collection('locations');
      // final FirebaseAuth auth = FirebaseAuth.instance;
      // final User? currentUser = auth.currentUser;
      // final String userId = currentUser?.uid ?? '';
      //
      // // Create a document with the user ID as the document ID
      // DocumentReference documentReference = locations.doc(userId);
      //
      // // Add the location data to the document
      // await documentReference.set({
      //   'userId': userId,
      //   'latitude': latitude,
      //   'longitude': longitude,
      //   'address' : _addressController.text,
      // });

      print('Location added to Firestore');
    } catch (e) {
      print('Error adding location to Firestore: $e');
    }
  }

  void _requestLocationPermission() async {
    await checkLocationPermission();
    setState(() {
      if (_permissionGranted != PermissionStatus.granted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Location Permission Required'),
            content: Text('This app requires access to your location.'),
            actions: [
              TextButton(
                child: Text('Deny'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Allow'),
                onPressed: () {
                  Navigator.of(context).pop();
                  loadData();
                },
              ),
            ],
          ),
        );
      }
    });
  }


  void _selectLocation(LatLng selectedLocation) {
    setState(() {
      _selectedLocation = selectedLocation;
      _latController.text = selectedLocation.latitude.toString();
      _longController.text = selectedLocation.longitude.toString();
    });
  }

  void _saveLocation() {
    if (_selectedLocation != null) {
      addLocationToFirestore(_selectedLocation!.latitude, _selectedLocation!.longitude);
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('Location Saved'),
          content: Text('The location has been saved.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('No Location Selected'),
          content: Text('Please select a location first.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionGranted == PermissionStatus.denied) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _requestLocationPermission,
            child: Text('Request Location Permission'),
          ),
        ),
      );
    } else if (!_serviceEnabled) {
      return Scaffold(
        body: Center(
          child: Text('Location service disabled. Please enable location services.'),
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: GoogleMap(
                      initialCameraPosition: _kGoogle,
                      markers: Set<Marker>.of(_markers),
                      mapType: MapType.hybrid,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      compassEnabled: true,
                      onTap: _selectLocation,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 15.h,bottom: 15.h),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.height / 160),
                        width: MediaQuery.of(context).size.width / 4.3,
                        height: MediaQuery.of(context).size.height / 130,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                ColorConstants.purple,
                                ColorConstants.lightBlue
                              ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      TextField(
                        style: TextStyle(fontSize: 13.sp),
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 13.sp),
                          labelText: 'Street Address',
                          enabled: true,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      TextField(
                        style: TextStyle(fontSize: 13.sp),
                        controller: _latController,
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          labelStyle: TextStyle(fontSize: 13.sp),
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      TextField(
                        style: TextStyle(fontSize: 13.sp),
                        controller: _longController,
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          labelStyle: TextStyle(fontSize: 13.sp),
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      custom_button(
                          label: 'Save Location',
                          backgroundcolor: ColorConstants.purple,
                          textcolor: Colors.white,
                          function: _saveLocation),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h,left: 25.w),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.purple,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 22.sp,),
                    )),
              ),
            ),

          ],
        ),
      );
    }
  }
}
