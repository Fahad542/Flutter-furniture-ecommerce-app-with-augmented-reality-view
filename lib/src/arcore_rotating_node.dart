import 'package:mart/src/arcore_node.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

import 'package:mart/src/shape/arcore_shape.dart';

class ArCoreRotatingNode extends ArCoreNode {
  ArCoreRotatingNode({
    required this.shape,
    required double degreesPerSecond,
    required Vector3 position,
    required Vector3 scale,
    required Vector4 rotation,
    required String name,
  })  : degreesPerSecond = ValueNotifier(90.0),
        super(
          shape: shape,
          name: name,
          position: position,
          scale: scale,
          rotation: rotation,
        );

  final ArCoreShape shape;

  final ValueNotifier<double> degreesPerSecond;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'degreesPerSecond': degreesPerSecond.value,
      }
        ..addAll(super.toMap())
        ..removeWhere((String k, dynamic v) => v == null);
}
