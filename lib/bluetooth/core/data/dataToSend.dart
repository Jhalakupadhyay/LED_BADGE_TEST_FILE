import 'package:json_annotation/json_annotation.dart';
import 'Messages.dart';

@JsonSerializable()
class DataToSend {
  final List<Message> messages;
  DataToSend({required this.messages});
}