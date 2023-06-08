import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mart/consts/consts.dart';

class googlemap extends StatefulWidget {
  const googlemap({super.key});

  @override
  State<googlemap> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<googlemap> {
  static final CameraPosition Google = CameraPosition(
    target: const LatLng(37.42796133580664, -122.085749655926),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google map"), backgroundColor: redColor),
      body: GoogleMap(
        initialCameraPosition: Google,
      ),
    );
  }
}
