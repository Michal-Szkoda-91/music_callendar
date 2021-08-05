import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalMethods {
  Face setFace({required int targetTime, required int playTime}) {
    Face face = Face(
      color: Colors.green,
      icon: CommunityMaterialIcons.emoticon,
    );
    return face;
  }
}

class Face {
  final Color color;
  final IconData icon;

  Face({required this.color, required this.icon});
}
