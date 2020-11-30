import 'package:flutter_api_test/annotation/api_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder apiBuilder(BuilderOptions options) => LibraryBuilder(
  ApiGenerator(),
  generatedExtension: '.api.util.dart'
);