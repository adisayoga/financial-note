/*
 * Copyright (c) 2017. All rights reserved.
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential.
 *
 * Written by:
 *   - Adi Sayoga <adisayoga@gmail.com>
 */

import 'dart:async';
import 'dart:convert';

import 'package:financial_note/data.dart';
import 'package:financial_note/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class Note implements Data {
  static const kNodeName = 'notes';

  final String bookId;

  String id;
  String title;
  String note;
  DateTime reminder;
  DateTime createdAt;
  DateTime updatedAt;

  Note(this.bookId, {
    this.id,
    this.title,
    this.note,
    this.reminder,
    this.createdAt,
    this.updatedAt,
  });

  Note.fromJson(this.bookId, this.id, Map<String, dynamic> json)
    : title     = parseString(valueOf(json, 'title')),
      note      = parseString(valueOf(json, 'note')),
      reminder  = parseDate(valueOf(json, 'reminder')),
      createdAt = parseDate(valueOf(json, 'createdAt')),
      updatedAt = parseDate(valueOf(json, 'updatedAt'));

  Note.fromSnapshot(String bookId, DataSnapshot snapshot)
    : this.fromJson(bookId, snapshot.key, snapshot.value);

  static Note of(String bookId) {
    return new Note(bookId);
  }

  Future<Note> get(String id) async {
    if (id == null) return null;
    final snap = await getNode(kNodeName, bookId).child(id).once();
    if (snap.value == null) return null;
    return new Note.fromSnapshot(bookId, snap);
  }

  Future<Null> save() async {
    final node = getNode(kNodeName, bookId);
    final ref = id != null ? node.child(id) : node.push();
    await ref.set(toJson());
    id = ref.key;
  }

  Future<Null> removeById(String id) async {
    if (id == null) return;
    await getNode(kNodeName, bookId).child(id).remove();
  }

  Future<Null> remove() async {
    await removeById(id);
  }

  Future<Map<String, dynamic>> scheduleNotification() async {
    // TODO: Ganti send to topic ke send to device group
    final httpClient = createHttpClient();
    final uri = getUri(kMessagingHost, kMessagingPath);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$kMessagingKey',
    };
    final json = {
      'priority': 'high',
      'to': '/topics/${currentBook.id}',
      'data': {
        'action': kScheduleNotification,
        'ref_id': id,
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      },
    };
    final response = await httpClient.post(
      uri, headers: headers, body: JSON.encode(json)
    );
    return JSON.decode(response.body);
  }

  Map<String, dynamic> toJson({showId: false}) {
    final json = {
      'id'        : id,
      'title'     : title,
      'note'      : note,
      'reminder'  : reminder?.toIso8601String(),
      'createdAt' : createdAt?.toIso8601String(),
      'updatedAt' : updatedAt?.toIso8601String(),
    };
    if (!showId) json.remove('id');
    return json;
  }
}
