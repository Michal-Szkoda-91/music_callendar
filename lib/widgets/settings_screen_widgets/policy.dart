import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyPrivacySetting extends StatefulWidget {
  @override
  _PolicyPrivacySettingState createState() => _PolicyPrivacySettingState();
}

class _PolicyPrivacySettingState extends State<PolicyPrivacySetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          launch("https://musiccalendar.000webhostapp.com/");
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Theme.of(context).backgroundColor,
          elevation: 6,
          shadowColor: Theme.of(context).primaryColor,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding: EdgeInsets.all(12),
            tileColor: Theme.of(context).backgroundColor,
            title: Text(
              'Politka Prywatności i Zasady użycia aplikacji',
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
