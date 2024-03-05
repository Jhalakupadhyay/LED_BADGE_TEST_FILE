import 'package:json_annotation/json_annotation.dart';
import 'package:badgemagic/bluetooth/core/data/Speed.dart';
import 'package:badgemagic/bluetooth/core/data/Mode.dart';

@JsonSerializable()
class Message {
  final String hexStrings;
  final bool flash;
  final bool marquee;
  final Speed speed;
  final Mode mode;

  Message({
    required this.hexStrings,
    this.flash = false,
    this.marquee = false,
    this.speed = Speed.ONE,
    this.mode = Mode.LEFT,
  });
}
