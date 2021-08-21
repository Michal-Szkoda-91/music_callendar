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
          color: Theme.of(context).backgroundColor,
          elevation: 12,
          child: ListTile(
            contentPadding: EdgeInsets.all(12),
            tileColor: Theme.of(context).backgroundColor,
            title: Text(
              'Politka Prywatności i Zasady użycia aplikacji',
              style: TextStyle(
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
