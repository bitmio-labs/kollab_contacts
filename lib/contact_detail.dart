import 'package:kollab_theme/kollab_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetail extends StatelessWidget {
  final KollabTheme theme;
  final Contact contact;

  ContactDetail({this.contact, this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: new Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(height: 60),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 90,
                  //margin: EdgeInsets.only(right: 25),
                  child: AspectRatio(
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(contact.imageURL)),
                    aspectRatio: 1,
                  )),
              Container(height: 10),
              Text(contact.name, style: theme.styleGuide.cardTitleStyle),
              Container(height: theme.styleGuide.cardTitlePropertySpacing),
              Text(contact.role, style: theme.styleGuide.cardPropertyStyle)
            ],
          ),
          Container(height: 20),
          ContactDetailRow(Icons.phone, "Telefon", contact.phone,
              clickHandler: callPhone, theme: theme),
          ContactDetailRow(Icons.email, "Email", contact.email,
              clickHandler: sendEmail, theme: theme),
          ContactDetailRow(Icons.timer, "Bürozeiten", contact.officeHours,
              theme: theme),
          Container(height: 20),
          Center(
              child: RaisedButton(
            onPressed: callPhone,
            color: theme.styleGuide.defaultButtonColor,
            padding: theme.styleGuide.buttonInsets,
            child: Text("Anrufen",
                style: theme.styleGuide.defaultButtonTitleStyle),
          ))
        ])));
  }

  callPhone() {
    launch('tel:${formatPhoneNumber(contact.phone)}');
  }

  sendEmail() {
    launch('mailto:${contact.email}');
  }
}

formatPhoneNumber(String number) {
  return number.replaceAll(RegExp(r"\s+\b|\b\s"), '');
}

class ContactDetailRow extends StatelessWidget {
  final KollabTheme theme;
  final String label;
  final IconData icon;
  final String value;
  final Function() clickHandler;

  ContactDetailRow(this.icon, this.label, this.value,
      {this.theme, this.clickHandler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: clickHandler,
        child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: theme.styleGuide.defaultInsets,
                    child: Row(children: [
                      Icon(icon, color: theme.styleGuide.cardPropertyIconColor),
                      SizedBox(width: theme.styleGuide.cardIconTitleSpacing),
                      Text(label,
                          style: theme.styleGuide.propertyListLabelStyle)
                    ]),
                  ),
                  SizedBox(height: 6),
                  Container(
                      margin: theme.styleGuide.defaultInsets,
                      child: Text(value,
                          style: clickHandler != null
                              ? theme
                                  .styleGuide.propertyListInteractiveValueStyle
                              : theme.styleGuide.propertyListValueStyle))
                ])));
  }
}
