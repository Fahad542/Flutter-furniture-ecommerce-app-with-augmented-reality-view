import 'arcore_pose.dart';

class ArCorePlane {
  late double extendX;
  late double extendZ;

  late ArCorePose centerPose;
  late ArCorePlaneType type;

  ArCorePlane.fromMap(Map<dynamic, dynamic> map) {
    extendX = map["extendX"];
    extendZ = map["extendZ"];
    centerPose = ArCorePose.fromMap(map["centerPose"]);
    type = ArCorePlaneType.values[map["type"] ?? 0];
  }
}

enum ArCorePlaneType {
  HORIZONTAL_UPWARD_FACING,
  HORIZONTAL_DOWNWARD_FACING,
  VERTICAL,
}
