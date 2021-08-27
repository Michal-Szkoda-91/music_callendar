import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../models/music_day_provider.dart';

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
            tr("Sensitive"),
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 12,
            ),
          ),
          Center(
            child: SfSliderTheme(
              data: SfSliderThemeData(
                activeLabelStyle: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 12,
                ),
                inactiveLabelStyle: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 12,
                ),
              ),
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
                interval: 20,
                showLabels: true,
                showTicks: true,
                labelFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  return actualValue == 20 ? '\max' : '\min';
                },
                activeColor: Theme.of(context).colorScheme.secondary,
                inactiveColor: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
