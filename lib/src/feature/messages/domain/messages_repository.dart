abstract class MessagesRepository {
  Future<void> backupAllMessages();
  Future<void> restoreAllMessages();
}
