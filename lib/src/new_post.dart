import 'dart:io';

import 'package:uuid/uuid.dart';

Future newPost(String title, String root, String type) async {
  if (await !FileSystemEntity.isDirectorySync(root)) {
    stderr.writeln("err: $root is not a directory");
  } else {
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
}

void createPost(String fileName, String title, String id) {
  File(fileName).create().then((file) async {
    final post =  file.openWrite(mode: FileMode.append);
    post.writeln('---');
    post.writeln('title: $title');
    post.writeln('id: $id');
    post.writeln('date: ' + DateTime.now().toUtc().toIso8601String().substring(0, 23) + 'Z');
    post.writeln('description: ');
    post.writeln('---');
    await post.close();
  });
}