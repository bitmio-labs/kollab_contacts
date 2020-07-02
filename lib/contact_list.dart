import 'package:kollab_theme/kollab_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/contact_model.dart';
import 'contact_detail.dart';

class SectionTitle extends StatelessWidget {
  final KollabTheme theme;
  final String title;

  SectionTitle({this.title, this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(title.toUpperCase(), style: theme.styleGuide.sectionTitleStyle);
  }
}

class TabHeader extends StatelessWidget {
  final KollabTheme theme;
  final String title;

  TabHeader({this.title, this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 25),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        child:
            Text(title.toUpperCase(), style: theme.styleGuide.tabBannerStyle));
  }
}

class ContactsScene extends StatelessWidget {
  final KollabTheme theme;
  final Contacts contacts;

  ContactsScene({this.contacts, this.theme});

  Widget build(BuildContext context) {
    return Container(
        color: theme.styleGuide.tabBackgroundColor,
        child: ListView(
          children: [
            Row(children: [
              TabHeader(title: 'Immer in Kontakt.', theme: theme)
            ]),
            Row(children: [
              Padding(
                padding: theme.styleGuide.defaultInsets,
                child: SectionTitle(
                    title: theme.theme.contacts.title, theme: theme),
              )
            ]),
            Container(height: theme.styleGuide.sectionTitleBottomSpacing),
            ContactsList(
                contacts: contacts != null ? contacts.items : null,
                theme: theme),
            Container(height: 20)
          ],
        ));
  }
}

class ContactsList extends StatelessWidget {
  final KollabTheme theme;
  final List<Contact> contacts;

  ContactsList({this.contacts, this.theme});

  @override
  Widget build(BuildContext context) {
    if (contacts == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Wrap(
        runSpacing: theme.styleGuide.cardListSpacing,
        children: contacts.map((each) {
          return Material(
              type: MaterialType.card,
              child: InkWell(
                onTap: () {
                  showContact(context, each);
                },
                child: ContactListItem(
                    contact: each, isInteractive: true, theme: theme),
              ));
        }).toList());
  }

  showContact(BuildContext context, Contact contact) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ContactDetail(contact: contact, theme: theme)));
  }
}

class ContactListItem extends StatelessWidget {
  final KollabTheme theme;
  final Contact contact;
  final bool isInteractive;

  ContactListItem({this.contact, this.isInteractive, this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: theme.styleGuide.defaultCardInsets,
        child: Row(children: <Widget>[
          Container(
              width: 51,
              //margin: EdgeInsets.only(right: 25),
              child: AspectRatio(
                child: CircleAvatar(
                    backgroundImage: NetworkImage(contact.imageURL)),
                aspectRatio: 1,
              )),
          Container(width: theme.styleGuide.cardIconTitleSpacing),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(contact.name, style: theme.styleGuide.cardTitleStyle),
                Container(height: theme.styleGuide.cardTitlePropertySpacing),
                Text(contact.role, style: theme.styleGuide.cardPropertyStyle)
              ])
        ]));
  }
}
