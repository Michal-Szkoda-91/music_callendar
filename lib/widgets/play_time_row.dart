import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/music_day_provider.dart';

class PlayTimeRow extends StatefulWidget {
  final int playTime;

  const PlayTimeRow({Key? key, required this.playTime}) : super(key: key);
  @override
  _PlayTimeRowState createState() => _PlayTimeRowState();
}

class _PlayTimeRowState extends State<PlayTimeRow> {
  late Duration actualPlayTime;
  bool _isCounting = false;
  @override
  void initState() {
    super.initState();
    actualPlayTime = Duration(seconds: widget.playTime);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MusicProvider>(context, listen: false)
        .setPlayTime(actualPlayTime.inSeconds);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Czas gry:',
                style: _customStyleSmall(),
              ),
              const SizedBox(width: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                child: Text(
                  '${actualPlayTime.toString().split(".")[0]}',
                  style: _customStyleBig(),
                ),
              ),
            ],
          ),
          //Temporary buuton to start and stop stoper

          !_isCounting
              ? IconButton(
                  onPressed: () {
                    incrasePlayTime();
                    if (mounted) {
                      setState(() {
                        _isCounting = !_isCounting;
                      });
                    }
                  },
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        _isCounting = !_isCounting;
                      });
                    }
                  },
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.pause,
                    size: 50,
                  ),
                ),
        ],
      ),
    );
  }

  TextStyle _customStyleSmall() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _customStyleBig() {
    return TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
    );
  }

  void incrasePlayTime() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (mounted) {
        setState(() {
          actualPlayTime += Duration(seconds: 1);
        });
      }
      Provider.of<MusicProvider>(context, listen: false)
          .setPlayTime(actualPlayTime.inSeconds);
      if (_isCounting) incrasePlayTime();
    });
  }
}
