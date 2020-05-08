import 'dart:io';

import 'package:args/args.dart';

import 'package:post_cli/post_cli.dart';

const contentType = "content-type";

ArgResults argResults;

main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(contentType, abbr: "t", defaultsTo: "blog", allowed: ["blog"], help: 'Type of content.');
  
  var title;
  try {
    argResults = parser.parse(args);
    title = argResults.rest[0];
  } catch (_) {
    print(parser.usage);
    exit(2);
  }
  final type = argResults[contentType];

  var file = File('${Directory.current.path}/package.json');

  if (!(await file.exists()) || (await file.readAsString()).indexOf('"gatsby":') == -1) {
    stderr.writeln('post-cli can only be run for a gatsby site.');
    stderr.writeln('Either the current working directory does not contain a valid package.json or \'gatsby\' is not specified as a dependency');
    exit(2);
  }

  newPost(title, Directory.current.path + '/content', type);
}

