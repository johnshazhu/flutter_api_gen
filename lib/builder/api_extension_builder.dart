import 'package:ivybaby_api/annotation/api_extension_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder apiExtensionBuilder(BuilderOptions options) => LibraryBuilder(
    ApiExtensionGenerator(),
    generatedExtension: '.impls.dart'
);