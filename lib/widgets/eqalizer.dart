import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class Equalizer extends StatelessWidget {
  const Equalizer({
    Key? key,
    required double equalizeSize,
    required bool isRecording,
  })  : _equalizeSize = equalizeSize,
        _isRecording = isRecording,
        super(key: key);

  final double _equalizeSize;
  final bool _isRecording;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width *
          (MediaQuery.of(context).orientation == Orientation.portrait
              ? 0.75
              : 0.3),
      height: MediaQuery.of(context).size.width *
          (MediaQuery.of(context).orientation == Orientation.portrait
              ? 0.75
              : 0.3),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: _equalizeSize,
        width: _equalizeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            stops: [_isRecording ? 0.9 : 0.0, 1],
            colors: [
              _isRecording ? Colors.red : Colors.redAccent,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Icon(
            !_isRecording
                ? CommunityMaterialIcons.music_off
                : CommunityMaterialIcons.music,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
