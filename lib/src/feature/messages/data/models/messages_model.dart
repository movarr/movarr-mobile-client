// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Message {
//     _id                INTEGER PRIMARY KEY,
  final int id;
//     thread_id          INTEGER,
  final int thread_id;
//     address            TEXT,s
  final String address;
//     person             INTEGER,
  final int person;
//     date               INTEGER,
  final int date; // kept int because we don't need it in ui for now
//     date_sent          INTEGER DEFAULT 0,
  final int date_sent;
//     protocol           INTEGER,
  final int protocol;
//     read               INTEGER DEFAULT 0,
  final int read;
//     status             INTEGER DEFAULT -1,
  final int status;
//     type               INTEGER,
  final int type;
//     reply_path_present INTEGER,
  final int reply_path_present;
//     subject            TEXT,
  final String? subject;
//     body               TEXT,
  final String? body;
//     service_center     TEXT,
  final String? service_center;
//     locked             INTEGER DEFAULT 0,
  final int locked;
//     error_code         INTEGER DEFAULT 0,
  final int error_code;
//     seen               INTEGER DEFAULT 0
  final int seen;

  Message({
    required this.id,
    required this.thread_id,
    required this.address,
    required this.person,
    required this.date,
    required this.date_sent,
    required this.protocol,
    required this.read,
    required this.status,
    required this.type,
    required this.reply_path_present,
    this.subject = ' ',
    this.body = '',
    this.service_center = ' ',
    required this.locked,
    required this.error_code,
    required this.seen,
  });

  factory Message.fromList(List source) {
    return Message(
        id: source[0],
        thread_id: source[1],
        address: source[2],
        person: source[3],
        date: source[4],
        date_sent: source[5],
        protocol: source[6],
        read: source[7],
        status: source[8],
        type: source[9],
        reply_path_present: source[10],
        subject: source[11],
        body: source[12],
        service_center: source[13],
        locked: source[14],
        error_code: source[15],
        seen: source[16]);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thread_id': thread_id,
      'address': address,
      'person': person,
      'date': date,
      'date_sent': date_sent,
      'protocol': protocol,
      'read': read,
      'status': status,
      'type': type,
      'reply_path_present': reply_path_present,
      'subject': subject,
      'body': body,
      'service_center': service_center,
      'locked': locked,
      'error_code': error_code,
      'seen': seen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id']?.toInt() ?? 0,
      thread_id: map['thread_id']?.toInt() ?? 0,
      address: map['address'] ?? '',
      person: map['person']?.toInt() ?? 0,
      date: map['date']?.toInt() ?? 0,
      date_sent: map['date_sent']?.toInt() ?? 0,
      protocol: map['protocol']?.toInt() ?? 0,
      read: map['read']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      reply_path_present: map['reply_path_present']?.toInt() ?? 0,
      subject: map['subject'] ?? '',
      body: map['body'] ?? '',
      service_center: map['service_center'] ?? '',
      locked: map['locked']?.toInt() ?? 0,
      error_code: map['error_code']?.toInt() ?? 0,
      seen: map['seen']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
