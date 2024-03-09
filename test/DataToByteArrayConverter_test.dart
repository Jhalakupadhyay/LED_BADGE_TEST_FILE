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
    expect(result[0].sublist(6, 7), [0x00]);
  });

  test(
      "flash should contain 8 bits, each bit representing the flash value of each message, 1 when flash is enabled, 0 otherwise",
      () {
    var data = DataToSend(messages: [
      Message(hexStrings: "Hii", flash: true),
      Message(hexStrings: "Hii", flash: true),
      Message(hexStrings: "Hii", flash: false),
      Message(hexStrings: "Hii", flash: false),
      Message(hexStrings: "Hii", flash: true),
      Message(hexStrings: "Hii", flash: false),
      Message(hexStrings: "Hii", flash: true),
      Message(hexStrings: "Hii", flash: false)
    ]);

    var result = convert(data);

    expect(result[0].sublist(6, 7), [0x53]); //binary is 01010011
  });

  test('marquee should be 0x00 when no messages have marquee option enabled',
      () {
    var data =
        DataToSend(messages: [Message(hexStrings: "Hii", marquee: false)]);

    var result = convert(data);

    expect(result[0].sublist(7, 8), [0x00]);
  });

  test(
      'marquee should contain 8 bits, each bit representing the marquee value of each message, 1 when marquee is enabled, 0 otherwise',
      () {
    var data = DataToSend(messages: [
      Message(hexStrings: "Hii", marquee: true),
      Message(hexStrings: "Hii", marquee: true),
      Message(hexStrings: "Hii", marquee: false),
      Message(hexStrings: "Hii", marquee: false),
      Message(hexStrings: "Hii", marquee: true),
      Message(hexStrings: "Hii", marquee: false),
      Message(hexStrings: "Hii", marquee: true),
      Message(hexStrings: "Hii", marquee: false)
    ]);

    var result = convert(data);

    expect(result[0].sublist(7, 8), [0x53]);
  });
}
