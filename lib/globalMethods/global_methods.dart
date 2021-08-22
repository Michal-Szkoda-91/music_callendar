import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalMethods {
  //methods which is setting a color and face icon depends on play time and targetTime proporcion
  Face setFace({required int targetTime, required int playTime}) {
    double proporcion = targetTime / playTime;
    Face face = Face(
      color: Colors.red,
      icon: CommunityMaterialIcons.emoticon,
    );
    if (proporcion > 3.3) {
      face = Face(
        color: Colors.red,
        icon: CommunityMaterialIcons.emoticon_sad,
      );
    } else if (proporcion <= 3.3 && proporcion > 1) {
      face = Face(
        color: Colors.orange,
        icon: CommunityMaterialIcons.emoticon_neutral,
      );
    } else {
      face = Face(
        color: Colors.green,
        icon: CommunityMaterialIcons.emoticon,
      );
    }
    return face;
  }
}

class Face {
  final Color color;
  final IconData icon;

  Face({required this.color, required this.icon});
}
