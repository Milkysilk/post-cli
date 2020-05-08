import 'dart:io';

import 'package:uuid/uuid.dart';

void newPost(String title, String root, String type) {
  final now = DateTime.now();
  var year = now.year;
  var month = now.month;
  var day = now.day;
  var uuid = Uuid().v4().replaceAll('-', '');
  var prefix = '$root/$type/$year/${month >= 10 ? month : "0${month}" }/${day >= 10 ? day : "0${day}" }/${uuid}';
  var directory = Directory(prefix);
  directory.exists().then((isThere) {
    final fileName = '$prefix/index.md';
    !isThere ? directory.create(recursive: true).then((directory) {
      createPost(fileName, title, uuid);
    }) : createPost(fileName, title, uuid);
  });
}

void createPost(String fileName, String title, String id) {
  File(fileName).create().then((file) {
    final post =  file.openWrite(mode: FileMode.append);
    post.writeln('---');
    post.writeln('title: $title');
    post.writeln('id: $id');
    post.writeln('date: ' + DateTime.now().toUtc().toIso8601String().substring(0, 23) + 'Z');
    post.writeln('description: ');
    post.writeln('---');
    post.close();
  });
}