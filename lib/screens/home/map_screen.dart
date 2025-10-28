import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/map_controller.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = Get.find<MapController>();
  late GoogleMapController mapController;

  static const String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        { "color": "#FFEFD4" }
      ]
    }
  ]
  ''';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  @override
  void initState() {
    super.initState();
    controller.initCall();
  }

  @override
  void dispose() {
    controller.disposeCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: controller.currentPosition != null
                  ? LatLng(
                      controller.currentPosition!.latitude,
                      controller.currentPosition!.longitude,
                    )
                  : const LatLng(0.0, 0.0), // fallback position
              zoom: 14.0,
            ),
            markers: controller.currentPosition != null
                ? {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(
                        controller.currentPosition!.latitude,
                        controller.currentPosition!.longitude,
                      ),
                      infoWindow: const InfoWindow(title: 'Your Location'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange,
                      ),
                    ),
                  }
                : {},
          ),
          Positioned(
            top: 50,
            left: 20,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: CustomSvgIcon(
                icon: AppIcons.arrowBackwardFilled,
                size: 30,
              ),
            ),
          ),
          Positioned(
            top: 90,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        cursorColor: AppColors.primaryColor,
                        cursorWidth: 1.5,
                        onChanged: controller.onChangeMapSearch,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 0,
                          ),
                          hintText: "enter_your_location".tr,
                          hintStyle: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 12,
                          ),
                          filled: true,
                          fillColor: AppColors.bgColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomSvgIcon(
                              icon: AppIcons.search,
                              size: 20,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: CustomSvgIcon(
                      icon: AppIcons.search,
                      color: AppColors.whiteColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: NearestChurchListView(),
          ),
        ],
      ),
    );
  }
}

class NearestChurchListView extends StatelessWidget {
  const NearestChurchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (controller) {
        final list = controller.nearestChurchList;
        return list.isEmpty
            ? SizedBox()
            : SizedBox(
                height: list.length == 1
                    ? 140
                    : list.length == 2
                    ? 270
                    : 390,
                child: ListView.builder(
                  itemCount: controller.nearestChurchList.length,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  itemBuilder: (context, index) {
                    double scale = 1.0;
                    final data = controller.nearestChurchList[index];
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        transform: Matrix4.identity()..scale(scale, scale),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.bgColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              if (data.photos != null &&
                                  data.photos!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: FadeInImage.assetNetwork(
                                    height: 95,
                                    width: 115,
                                    fit: BoxFit.cover,
                                    placeholder: AppImages.churchPlaceholder,
                                    image:
                                        data.photos!.first.photoReference ?? '',
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                          return Image.asset(
                                            AppImages.churchPlaceholder,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                  ),
                                )
                              else
                                Container(
                                  height: 95,
                                  width: 115,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AppImages.churchPlaceholder,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: data.name ?? '-',
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      maxLines: 2,
                                    ),
                                    CustomText(
                                      text: data.vicinity ?? '-',
                                      color: AppColors.primaryColor,
                                      fontSize: 11,
                                      maxLines: 2,
                                    ),
                                    starRating(data.rating ?? 0.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }

  Widget starRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double starValue = index + 1;
        if (rating >= starValue) {
          // full star
          return Icon(Icons.star, color: AppColors.primaryColor, size: 24);
        } else if (rating > starValue - 1 && rating < starValue) {
          // half star
          return Icon(Icons.star_half, color: AppColors.primaryColor, size: 24);
        } else {
          // empty star
          return Icon(
            Icons.star_border,
            color: AppColors.primaryColor,
            size: 24,
          );
        }
      }),
    );
  }
}
