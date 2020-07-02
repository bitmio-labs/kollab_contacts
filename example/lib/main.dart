import 'package:flutter/material.dart';
import 'package:kollab_contacts/kollab_contacts.dart';
import 'package:kollab_theme/kollab_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final theme = await KollabTheme.defaultTheme;
  runApp(MyApp(theme: theme));
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  final KollabTheme theme;

  static const String _title = 'Kollab Contacts Example';

  MyApp({this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(theme: theme),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final KollabTheme theme;

  MyStatefulWidget({this.theme});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Stream<Contacts> _contacts = (() async* {
    final contacts = await Contacts.examples;
    yield contacts;
  })();

  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        color: Colors.white,
        child: StreamBuilder<Contacts>(
          stream: _contacts,
          builder: (BuildContext context, AsyncSnapshot<Contacts> snapshot) {
            List<Widget> children;
            if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  children = <Widget>[
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Disconnected.'),
                    )
                  ];
                  break;
                case ConnectionState.waiting:
                  children = <Widget>[
                    SizedBox(
                      child: const CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading...'),
                    )
                  ];
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  children = <Widget>[
                    Expanded(
                        child: ContactsScene(
                            contacts: snapshot.data, theme: this.widget.theme))
                  ];
                  break;
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
          },
        ),
      ),
    );
  }
}
