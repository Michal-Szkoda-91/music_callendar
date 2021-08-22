import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/setting_providers.dart';
import '../../widgets/settings_screen_widgets/tooltip.dart';

class StopRecordTimeSetting extends StatefulWidget {
  @override
  _StopRecordTimeSettingState createState() => _StopRecordTimeSettingState();
}

class _StopRecordTimeSettingState extends State<StopRecordTimeSetting> {
  final String text =
      'Ustawia czas ciszy potrzebny do zatrzymania naliczania czasu gry na instrumencie.';

  String _actualValue = '3 sec';
  @override
  void initState() {
    super.initState();
    _actualValue = getStopRecordTime();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Theme.of(context).primaryColor,
        color: Theme.of(context).backgroundColor,
        elevation: 6,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.all(6),
          tileColor: Theme.of(context).backgroundColor,
          title: Text(
            'Opóźnienie zatrzymania nagrywania',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          leading: CustomToolTip(
            content: text,
          ),
          trailing: Card(
            color: Theme.of(context).backgroundColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                dropdownColor: Theme.of(context).backgroundColor,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
                underline: Container(height: 0),
                iconDisabledColor: Theme.of(context).textTheme.headline1!.color,
                iconEnabledColor: Theme.of(context).textTheme.headline1!.color,
                value: _actualValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _actualValue = newValue!;
                    setStopRecordTime(_actualValue);
                  });
                },
                items: <String>['1 sec', '2 sec', '3 sec', '4 sec', '5 sec']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setStopRecordTime(String value) {
    var data = Provider.of<SettingProvider>(context, listen: false);
    switch (value) {
      case '1 sec':
        data.setWaitStopRecordTime(0.35);
        break;
      case '2 sec':
        data.setWaitStopRecordTime(0.17);
        break;
      case '3 sec':
        data.setWaitStopRecordTime(0.12);
        break;
      case '4 sec':
        data.setWaitStopRecordTime(0.07);
        break;
      case '5 sec':
        data.setWaitStopRecordTime(0.05);
        break;
      default:
        data.setWaitStopRecordTime(0.12);
    }
  }

  String getStopRecordTime() {
    var data = Provider.of<SettingProvider>(context, listen: false);
    var val = data.settingModel.waitForStopRecordTime.toString();
    String tempVal = '3 sec';
    switch (val) {
      case '0.35':
        tempVal = '1 sec';
        break;
      case '0.17':
        tempVal = '2 sec';
        break;
      case '0.12':
        tempVal = '3 sec';
        break;
      case '0.07':
        tempVal = '4 sec';
        break;
      case '0.05':
        tempVal = '5 sec';
        break;
      default:
        tempVal = '3 sec';
        break;
    }
    return tempVal;
  }
}
