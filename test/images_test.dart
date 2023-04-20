import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdemo/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.email).existsSync(), true);
    expect(File(Images.facebook).existsSync(), true);
    expect(File(Images.google).existsSync(), true);
    expect(File(Images.logo).existsSync(), true);
    expect(File(Images.password).existsSync(), true);
    expect(File(Images.profileBg).existsSync(), true);
    expect(File(Images.sampleProfile).existsSync(), true);
    expect(File(Images.shirt).existsSync(), true);
    expect(File(Images.splash).existsSync(), true);
  });
}
