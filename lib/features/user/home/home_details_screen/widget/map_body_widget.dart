import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBodyWidget extends StatelessWidget {
  const MapBodyWidget({
    super.key,
    this.locationName,
    this.latitude = 33.888630, // Beirut, Lebanon
    this.longitude = 35.495480,
    this.zoom = 15.0,
  });

  final String? locationName;
  final double latitude;
  final double longitude;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('location_marker'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: locationName ?? 'Location',
        ),
      ),
    };

    return Center(
      child: SizedBox(
        height: 190,
        width: 335,
        child: Column(
          children: [
            Container(
              height: 160,
              width: 335,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: zoom,
                  ),
                  markers: markers,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  // gestureRecognizers লাইনটা সরিয়ে দাও (এটাই মূল সমস্যা)
                  // liteModeEnabled: true, // যদি static map চাও (Android-এ কাজ করে)
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    locationName ?? 'Unknown Location',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}