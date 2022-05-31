import 'package:movarr/src/feature/messages/data/models/messages_model.dart';
import 'package:movarr/src/feature/messages/data/services/message_service.dart';
import 'package:movarr/src/feature/messages/domain/messages_repository.dart';

class MessageRepositoryImpl implements MessagesRepository {
  @override
  Future<void> backupAllMessages() async {
    List<Message> messages = await MessageServices().getAllMessages();
    return;
  }

  @override
  Future<void> restoreAllMessages() async {
    return;
  }
}
