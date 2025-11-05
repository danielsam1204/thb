import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/common/app_constant.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/domain/helpers/helper_func.dart';
import 'package:thb/domain/models/google_map_response.dart';
import 'package:thb/domain/models/google_map_search_response.dart';
import 'package:thb/widgets/custom_snackbar.dart';

class MapController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  MapController({required this.sharedPreferences});

  static final Dio _dio = Dio();
  late TextEditingController searchController;
  List<MapData> _nearestChurchList = [];
  List<Predictions> searchData = [];
  LatLng? _currentPosition;
  Timer? _debounce;
  String _languageCode = "ta";
  Set<Marker> _markers = {};
  GoogleMapController? mapController;
  bool enableSearch = false;
  bool _loadingState = true;
  final String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        { "color": "#FFEFD4" }
      ]
    }
  ]
  ''';

  List<MapData> get nearestChurchList => _nearestChurchList;

  LatLng? get currentPosition => _currentPosition;

  Set<Marker> get markers => _markers;

  bool get loadingState => _loadingState;

  Future<void> getCurrentPosition() async {
    _loadingState = true;
    update();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentPosition = LatLng(position.latitude, position.longitude);
    _markers = {};
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentPosition!,
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    );
    _loadingState = false;
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.setMapStyle(_mapStyle);
  }

  void getLanguageCode() {
    final language = sharedPreferences.getString("language") ?? 'ta_In';
    _languageCode = HelperFunc.getLanguageCode(language);
  }

  Future<void> getNearestChurches() async {
    double lat = 0.0;
    double lng = 0.0;
    if (currentPosition != null) {
      lat = currentPosition!.latitude;
      lng = currentPosition!.longitude;
    }
    final url =
        '${AppConstant.nearBySearch}?location=$lat,$lng&radius=3000&type=church&language=$_languageCode&key=${AppConstant.mapApiKey}';
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        Logger().i(response.data);
        GoogleMapResponse mapResponse = GoogleMapResponse.fromJson(
          response.data,
        );
        final status = mapResponse.status;
        if (status == 'OK') {
          Set<Marker> churchMarkers = {};
          _nearestChurchList = mapResponse.results ?? [];
          for (var church in nearestChurchList) {
            final lat = church.geometry!.location!.lat ?? 0.0;
            final lng = church.geometry!.location!.lng ?? 0.0;
            final name = church.name ?? '';

            churchMarkers.add(
              Marker(
                markerId: MarkerId(name),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: name),
                icon:await BitmapDescriptor.asset(
                  const ImageConfiguration(size: Size(48, 48)), // optional size hint
                  AppIcons.churchMarker,
                ),
              ),
            );
          }
          markers.addAll(churchMarkers);
        } else {
          _nearestChurchList = [];
        }
      }
    } on DioError catch (e) {
      showCustomSnackBar('Network error: ${e.message}');
    } catch (_) {}
    enableSearch = false;
    update();
  }

  Future<void> onChangeMapSearch(String? input) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await autoComplete(input);
    });
  }

  Future<void> autoComplete(String? input) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$_languageCode&key=${AppConstant.mapApiKey}';
      final response = await _dio.get(url);
      Logger().d(response.data);
      if (response.statusCode == 200) {
        GoogleMapSearchResponse googleMapSearchResponse =
            GoogleMapSearchResponse.fromJson(response.data);
        final status = googleMapSearchResponse.status;
        if (status == 'OK') {
          Logger().i(googleMapSearchResponse.toJson());
          searchData = googleMapSearchResponse.predictions ?? [];
        } else {
          searchData = [];
        }
      }
    } catch (_) {}
    update();
  }

  Future<void> getPlaceCoordinates(String placeId) async {
    FocusScope.of(Get.context!).unfocus();
    searchController.clear();
    _loadingState = true;
    update();
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&language=$_languageCode&key=${AppConstant.mapApiKey}';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final status = response.data["status"];
        if (status == 'OK') {
          final lat = response.data["result"]["geometry"]["location"]["lat"];
          final lng = response.data["result"]["geometry"]["location"]["lng"];
          _currentPosition = LatLng(lat, lng);
          _markers = {};
          markers.add(
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: currentPosition!,
              infoWindow: const InfoWindow(title: 'Your Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
            ),
          );
          await getNearestChurches();
        }
      }
    } catch (_) {}
    searchData = [];
    _loadingState = false;
    update();
  }

  initCall() async {
    searchController = TextEditingController();
    getLanguageCode();
    await getCurrentPosition();
    if (currentPosition != null) {
      await getNearestChurches();
    }
  }

  disposeCall() {
    mapController?.dispose();
    searchController.dispose();
    clearData();
  }

  void clearData() {
    _markers = {};
    _nearestChurchList = [];
  }

  void onTapClearSearch() {
    searchController.clear();
    searchData = [];
    update();
  }

  Future<void> onTapCurrentPosition() async {
    FocusScope.of(Get.context!).unfocus();
    searchController.clear();
    enableSearch = false;
    await getCurrentPosition();
    await getNearestChurches();
  }

  void onTapPop() {
    if (enableSearch) {
      FocusScope.of(Get.context!).unfocus();
      searchController.clear();
      searchData = [];
      enableSearch = false;
      update();
    } else {
      Navigator.pop(Get.context!);
    }
  }

  void onTapEnableSearch(bool val) {
    enableSearch = val;
    update();
  }
}
