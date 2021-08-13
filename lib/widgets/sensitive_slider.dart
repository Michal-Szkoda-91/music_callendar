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
      padding: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width *
          (MediaQuery.of(context).orientation == Orientation.portrait
              ? 0.2
              : 0.1),
      child: Column(
        children: [
          Text(
            "Czułość",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SfSlider.vertical(
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
            interval: 20,
            showLabels: true,
            labelFormatterCallback:
                (dynamic actualValue, String formattedText) {
              return actualValue == 20 ? '\max' : '\min';
            },
            activeColor: Theme.of(context).accentColor,
            inactiveColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
