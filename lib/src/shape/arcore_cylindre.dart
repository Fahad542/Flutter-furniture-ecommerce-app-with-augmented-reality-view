import 'package:mart/src/shape/arcore_shape.dart';
import 'package:mart/src/arcore_material.dart';

class ArCoreCylinder extends ArCoreShape {
  ArCoreCylinder({
    this.radius = 0.5,
    this.height = 1.0,
    required List<ArCoreMaterial> materials,
  }) : super(
          materials: materials,
        );

  final double height;
  final double radius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'height': this.radius,
        'radius': this.height,
      }..addAll(super.toMap());
}
