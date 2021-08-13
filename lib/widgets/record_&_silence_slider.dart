import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:music_callendar/models/music_day_provider.dart';
import 'package:provider/provider.dart';

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
              duration: Duration(milliseconds: 50),
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
                    0,
                    Provider.of<MusicProvider>(context, listen: false)
                        .silenceCounter
                  ],
                  colors: [
                    Colors.red,
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 50),
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.4
                      : 0.15),
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                    0,
                    Provider.of<MusicProvider>(context, listen: false)
                        .recordCounter
                  ],
                  colors: [
                    Colors.green,
                    Theme.of(context).primaryColor,
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
            Icon(CommunityMaterialIcons.music_off, color: Colors.red),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.7
                      : 0.25),
            ),
            Icon(CommunityMaterialIcons.music, color: Colors.green),
          ],
        )
      ],
    );
  }
}
