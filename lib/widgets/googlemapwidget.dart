
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget(
      {super.key,
      required this.lat,
      required this.markers,
      required this.long,
      required this.onMapCreated});
  final double lat, long;
   Function(GoogleMapController)? onMapCreated ;
  Set<Marker> markers ;
  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {



  @override

  @override
  Widget build(BuildContext context) {


    return GoogleMap(
        markers: Set.of(widget.markers),
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0.0, 0.0),
          zoom: 14,
        ),
        onMapCreated: widget.onMapCreated);
  }
}
