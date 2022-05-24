import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsService {
  Future<int> getContactsCount() async {
    final contacts = await FlutterContacts.getContacts();
    return contacts.length;
  }

  Future<bool> requestContactsPermission() async =>
      await FlutterContacts.requestPermission();

  Future<List<Contact>> getContacts() async =>
      await FlutterContacts.getContacts();
}
