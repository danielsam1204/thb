import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';

class LocationLoader extends StatefulWidget {
  const LocationLoader({super.key});

  @override
  State<LocationLoader> createState() => _LocationLoaderState();
}

class _LocationLoaderState extends State<LocationLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 90 * _animation.value + 20,
                height: 90 * _animation.value + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(
                    1 - _animation.value,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  AppIcons.locationOnOutlined,
                  color: AppColors.fontOffWhiteColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}