import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:thb/common/app_constant.dart';
import 'package:thb/domain/models/google_map_response.dart';
import 'package:thb/widgets/custom_snackbar.dart';

class MapController extends GetxController implements GetxService {
  static final Dio _dio = Dio();
  List<MapData> _nearestChurchList = [];
  Position? _currentPosition;

  List<MapData> get nearestChurchList => _nearestChurchList;

  Position? get currentPosition => _currentPosition;

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> fetchNearestChurches({
    required double lat,
    required double lng,
  }) async {
    _nearestChurchList = [];
    final url =
        '${AppConstant.nearBySearch}?location=$lat,$lng&radius=3000&type=church&key=${AppConstant.mapApiKey}';
    final photoReference =
        "AWn5SU5ZylrZD2wCKPNYecQvsmIfp76R1il_OE7mJwSQlmLOYfDYu8OMBwBc9atVyl9WSK-IKrZRfrmIx894VgUGis3wNTYAtiIr9GpRjjhdPr9iNW8qhJnP8Yf3qi86P1QjbCYZLsB1Fl1jdGlQuzwnYVUApr3-Qq_DKAm46Q0lOV5rK6EEWokni5beI--tvKMnMkUwvj9-iEh93jtWQ2FRtmpGb0n9IVzGqSuVCyaEDONJoP3kvmoMYkwQzsZV0r1BWWL2W0qHDZqwDhyrZQnBDvNWjY0t-ez1OSc4G7r5OG0cFS9O0HgfYoZSVtT5WHBOyuKcN71VcOA";
    final test =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photo_reference=$photoReference&key=${AppConstant.mapApiKey}';
    try {
      print("test===>>> $test");
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        GoogleMapResponse mapResponse = GoogleMapResponse.fromJson(
          response.data,
        );
        final status = mapResponse.status;
        if (status == 'OK') {
          Logger().i(mapResponse.toJson());
          _nearestChurchList = mapResponse.results ?? [];
        }
      }
    } on DioError catch (e) {
      showCustomSnackBar('Network error: ${e.message}');
    } catch (_) {}
    update();
  }

  Future<void> onChangeMapSearch(String? input) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${AppConstant.mapApiKey}';
    final response = await _dio.get(url);
    Logger().d(response.data);
  }

  initCall() async {
    _currentPosition = await getCurrentPosition();
    if (currentPosition != null) {
      await fetchNearestChurches(
        lat: currentPosition!.latitude,
        lng: currentPosition!.longitude,
      );
    }
  }

  disposeCall() {
    clearData();
  }

  void clearData() {
    _nearestChurchList = [];
  }
}
