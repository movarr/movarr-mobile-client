import 'package:movarr/src/features/contact/domain/contact_repository.dart';
import 'package:movarr/src/features/contact/services/contacts_service.dart';

class ContactRepositoryImpl implements ContactRepository {
  late ContactsService _contactsService;
  ContactRepositoryImpl() {
    _contactsService = ContactsService();
  }
  @override
  Future<void> backupContacts() async {
    final contacts = await _contactsService.getContacts();
    if (contacts.isNotEmpty) {
      final contactsMap = contacts.map((contact) => contact.toJson()).toList();
    }
    //TODO: Complete implementation of backup using Network repository
    throw UnimplementedError();
  }

  @override
  Future<int> fetchContactsCount() async {
    await _contactsService.requestContactsPermission();
    return _contactsService.getContactsCount();
  }
}
