import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:khampha/map/locationservice.dart';
import 'package:latlong2/latlong.dart';

class BanDoSo extends StatefulWidget {
  const BanDoSo({super.key});

  @override
  State<BanDoSo> createState() => _BanDoSoState();
}

class _BanDoSoState extends State<BanDoSo> {
  LatLng? center;
  final LocationService _locationService = LocationService();
  late final DefaultCacheManager cacheManager = DefaultCacheManager();

  Future<void> _updateCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      setState(() {
        center = LatLng(position!.latitude, position.longitude);
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _showErrorDialog(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _updateCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    cacheManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (center != null)
            FlutterMap(
              mapController: MapController(),
              options: MapOptions(
                initialCenter: center!,
                initialZoom: 8,
                // initialRotation: false // Đặt giá trị mặc định
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  tileProvider: CancellableNetworkTileProvider(),
                ),
              ],
            ),
          _updateGPS(context),
        ],
      ),
    );
  }

  Widget _updateGPS(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: _updateCurrentLocation,
        child: const Icon(Icons.explore),
      ),
    );
  }
}
