abstract class ContactRepository {
  Future<int> fetchContactsCount();
  Future<void> backupContacts();
}
