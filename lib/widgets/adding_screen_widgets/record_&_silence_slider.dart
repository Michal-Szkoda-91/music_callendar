import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/music_day_provider.dart';

class RecordSilenceSlider extends StatefulWidget {
  RecordSilenceSlider({Key? key}) : super(key: key);

  @override
  _RecordSilenceSliderState createState() => _RecordSilenceSliderState();
}

class _RecordSilenceSliderState extends State<RecordSilenceSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 20),
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.4
                      : 0.15),
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: [
                    Provider.of<MusicProvider>(context, listen: false)
                            .silenceCounter +
                        0.05,
                    0,
                  ],
                  colors: [
                    Colors.red,
                    Theme.of(context).backgroundColor,
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 20),
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.4
                      : 0.15),
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                    Provider.of<MusicProvider>(context, listen: false)
                            .recordCounter +
                        0.05,
                    0,
                  ],
                  colors: [
                    Colors.green,
                    Theme.of(context).backgroundColor,
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CommunityMaterialIcons.headphones_off, color: Colors.red),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.7
                      : 0.25),
            ),
            Icon(CommunityMaterialIcons.headphones, color: Colors.green),
          ],
        )
      ],
    );
  }
}
