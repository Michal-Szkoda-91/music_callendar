import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/setting_providers.dart';
import '../../widgets/settings_screen_widgets/tooltip.dart';

class AutosaveSetting extends StatefulWidget {
  @override
  _AutosaveSettingState createState() => _AutosaveSettingState();
}

class _AutosaveSettingState extends State<AutosaveSetting> {
  final String text = tr("AutoSaveDescription");

  bool _actualValue = true;
  @override
  void initState() {
    super.initState();
    var data = Provider.of<SettingProvider>(context, listen: false);
    _actualValue = data.settingModel.autoSaveIsOn!;
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
            tr("AutoSaveTitle"),
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          leading: CustomToolTip(
            content: text,
          ),
          trailing: Column(
            children: [
              Spacer(),
              Container(
                height: 20,
                child: CupertinoSwitch(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  trackColor: Theme.of(context).cardColor,
                  onChanged: (val) {
                    var data =
                        Provider.of<SettingProvider>(context, listen: false);
                    data.setAutoSave(val);
                    setState(() {
                      _actualValue = val;
                    });
                  },
                  value: _actualValue,
                ),
              ),
              Spacer(),
              Text(
                _actualValue ? 'ON' : 'OFF',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
