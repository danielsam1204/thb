import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/controllers/map_controller.dart';
import 'package:thb/screens/map/widget/location_loader.dart';
import 'package:thb/screens/map/widget/nearest_church_list_view.dart';
import 'package:thb/screens/map/widget/search_view.dart';
import 'package:thb/widgets/custom_search_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<MapController>();

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (controller.enableSearch) {
          FocusScope.of(context).unfocus();
          controller.onTapEnableSearch(false);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          });
        }
      },
      child: Scaffold(
        body: GetBuilder<MapController>(
          builder: (controller) {
            final position = controller.currentPosition;
            return Stack(
              children: [
                controller.loadingState
                    ? LocationLoader()
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder: (child, animation) {
                          final fade = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          );
                          return FadeTransition(
                            opacity: fade,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 0.1),
                                end: Offset.zero,
                              ).animate(fade),
                              child: child,
                            ),
                          );
                        },
                        child: controller.enableSearch
                            ? SearchView()
                            : (position != null
                                  ? GoogleMap(
                                      key: const ValueKey('googleMap'),
                                      onMapCreated: controller.onMapCreated,
                                      zoomControlsEnabled: false,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          position.latitude,
                                          position.longitude,
                                        ),
                                        zoom: 14.0,
                                      ),
                                      markers: controller.markers,
                                    )
                                  : const SizedBox()),
                      ),

                Positioned(
                  top: 50,
                  left: 20,
                  child: InkWell(
                    onTap: controller.onTapPop,
                    child: CustomSvgIcon(
                      icon: AppIcons.arrowBackwardFilled,
                      size: 30,
                    ),
                  ),
                ),
                if (!controller.loadingState)
                  Positioned(
                    top: 90,
                    right: 0,
                    left: 0,
                    child: CustomSearchBar(
                      disableAction: true,
                      suffixIcon: controller.searchController.text.isEmpty
                          ? null
                          : InkWell(
                              onTap: controller.onTapClearSearch,
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: CustomSvgIcon(
                                  icon: AppIcons.clear,
                                  size: 20,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                      controller: controller.searchController,
                      hintText: "enter_your_location".tr,
                      onChanged: controller.onChangeMapSearch,
                      onTap: () => controller.onTapEnableSearch(true),
                    ),
                  ),
                if (!controller.enableSearch && !controller.loadingState)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      opacity: controller.enableSearch ? 0 : 1,
                      child: const NearestChurchListView(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}




