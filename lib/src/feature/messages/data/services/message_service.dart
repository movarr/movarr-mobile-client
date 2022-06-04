import 'package:android_content_provider/android_content_provider.dart';
import 'package:movarr/src/feature/messages/data/models/messages_model.dart';

class MessageServices {
  final String smsInboxUri = 'content://sms/inbox';
  late final AndroidContentResolver contentResolver;
  MessageServices() {
    contentResolver = AndroidContentResolver.instance;
  }

  Future<int> getNumberOfMessages() async {
    final cursor =
        await contentResolver.query(uri: smsInboxUri, projection: ['_id']);
    return (await cursor!.batchedGet().getCount().commit()).first as int;
  }

  Future<List<Message>> getAllMessages() async {
    final cursor = await contentResolver.query(
      uri: smsInboxUri,
      // projection order corresponds to the Message Model
      projection: [
        '_id', //                         0
        'thread_id', //                   1
        'address', //                     2
        'person', //                      3
        'date', //                        4
        'date_sent', //                   5
        'protocol', //                    6
        'read', //                        7
        'status', //                      8
        'type', //                        9
        'reply_path_present', //          10
        'subject', //                     11
        'body', //                        12
        'service_center', //              13
        'locked', //                      14
        'error_code', //                  15
        'seen' //                         16
      ],
      selection: null,
      selectionArgs: null,
      sortOrder: null,
    );
    cursor!.moveToFirst();
    final int end =
        (await cursor.batchedGet().getCount().commit()).first as int;
    final List<Message> messages = [];
    final batch = await cursor
        .batchedGet()
        .getInt(0) // id
        .getInt(1) // thread_id
        .getString(2) // address
        .getInt(3) // person
        .getInt(4) // date
        .getInt(5) // date_sent
        .getInt(6) // protocol
        .getInt(7) // read
        .getInt(8) // status
        .getInt(9) // type
        .getInt(10) // reply_path_present
        .getString(11) // subject
        .getString(12) // body
        .getString(13) // service_center
        .getInt(14) // locked
        .getInt(15) // error_code
        .getInt(16) // seen
        .commitRange(0,
            end); // this operation is heavy and should not be done on the main thread

    for (int i = 0; i < batch.length; ++i) {
      messages.add(Message.fromList(batch[i]));
    }

    return messages;
  }

  Future<int> restoreMessage(Message message) async {
    final contentValues = ContentValues()
      ..putString(
        'address',
        'GT',
      )
      ..putInt('person', message.person)
      ..putString('date', message.date.toString())
      ..putInt('date_sent', message.date_sent)
      ..putInt(
        'protocol',
        message.protocol,
      )
      ..putInt(
        'read',
        message.read,
      )
      ..putInt(
        'status',
        message.status,
      )
      ..putInt(
        'type',
        message.type,
      )
      ..putInt(
        'reply_path_present',
        message.reply_path_present,
      )
      ..putString(
        'subject',
        message.subject,
      )
      ..putString(
        'body',
        message.body,
      )
      ..putString(
        'service_center',
        message.service_center,
      )
      ..putInt('seen', message.seen);
    final result = await contentResolver.insert(
        uri: 'content://sms', values: contentValues);
    return int.parse(result!.split('/').last);
  }
}
