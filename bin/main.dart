import 'dart:io';

import 'package:args/args.dart';

import 'package:post_cli/post_cli.dart';

const contentRoot = "content-root";
const contentType = "content-type";

ArgResults argResults;

main(List<String> args) {
  final parser = ArgParser()
    ..addOption(contentRoot, abbr: "r", help: 'The content directory of GatsbyJS site.')
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

  final envVarMap = Platform.environment;

  // print("$title, $type, ${envVars[contentRoot]}, ${argResults[contentRoot]}");
  
  if (envVarMap[contentRoot] == null && argResults[contentRoot] == null) {
    exitCode = 2;
  }

  var root = envVarMap[contentRoot] ?? argResults[contentRoot];

  newPost(title, root, type);
}

