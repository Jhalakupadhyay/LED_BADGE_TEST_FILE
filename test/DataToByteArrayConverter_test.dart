import 'package:badgemagic/bluetooth/core/DataToByteArrayConverter.dart';
import 'package:badgemagic/bluetooth/core/data/Messages.dart';
import 'package:badgemagic/bluetooth/core/data/dataToSend.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('result should start with 77616E670000', () {
    var data = DataToSend(messages: [Message(hexStrings: 'A')]);
    var result = convert(data);
    expect(result[0].sublist(0, 6), [0x77, 0x61, 0x6E, 0x67, 0x00, 0x00]);
  });

  test('flash should be 0x00 when no messages have flash option enabled', () {
    var data = DataToSend(messages: [Message(hexStrings: 'A')]);

    var result = convert(data);
    expect(result[0].sublist(6,7), [0x00]);
  });
}
