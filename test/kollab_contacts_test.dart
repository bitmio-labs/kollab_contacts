import 'package:flutter_test/flutter_test.dart';

import 'package:kollab_contacts/kollab_contacts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('parses model', () async {
    final model = await Contacts.examples;

    expect(model.items.length, 4);
    expect(model.items[0].email, 'timlee@example.com');
  });
}
