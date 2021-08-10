import 'package:flutter/material.dart';
import 'package:music_callendar/models/music_day_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SensitiveSlider extends StatefulWidget {
  @override
  _SensitiveSliderState createState() => _SensitiveSliderState();
}

class _SensitiveSliderState extends State<SensitiveSlider> {
  late double _sliderValue;

  @override
  Widget build(BuildContext context) {
    _sliderValue = Provider.of<MusicProvider>(context).sensitive;
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      child: SfSlider.vertical(
        showDividers: true,
        value: _sliderValue,
        onChanged: (value) {
          Provider.of<MusicProvider>(context, listen: false)
              .setSensitive(value);
          setState(() {
            _sliderValue = value;
          });
        },
        max: 20,
        min: 0,
        interval: 10,
        showLabels: true,
      ),
    );
  }
}
