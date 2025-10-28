//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class GasListScreen extends StatefulWidget {
//   @override
//   _GasListScreenState createState() => _GasListScreenState();
// }
//
// class _GasListScreenState extends State<GasListScreen> {
//   List<Map<String, dynamic>> _stations = [];
//   bool _loading = true;
//   String apiKey = 'AIzaSyCi2q9rEJ0LUgbgw7aD49U_o-q_UX8LDC0';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadStations();
//   }
//
//   Future<void> _loadStations() async {
//     try {
//       final pos = await NearbyGasStations.getCurrentPosition();
//       final stations = await NearbyGasStations.fetchNearbyGasStations(
//         lat: pos.latitude,
//         lng: pos.longitude,
//         radius: 5000,
//         apiKey: apiKey,
//       );
//       setState(() {
//         _stations = stations;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() => _loading = false);
//       print(e);
//       // show error to user
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_loading) return Center(child: CircularProgressIndicator());
//     if (_stations.isEmpty) return Center(child: Text('No petrol bunks found'));
//
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: _stations.length,
//         itemBuilder: (_, i) {
//           final s = _stations[i];
//           final name = s['name'] ?? 'Unknown';
//           final address = s['vicinity'] ?? s['formatted_address'] ?? '';
//           final rating = s['rating']?.toString() ?? '';
//           return ListTile(
//             title: Text(name),
//             subtitle: Text(address + (rating != '' ? ' • ⭐ $rating' : '')),
//           );
//         },
//       ),
//     )
//       ;
//   }
// }