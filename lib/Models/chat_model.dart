import 'package:netflix/Models/chat_message_model.dart';

class ChatModel {
  final String uid;
  final String currentUserUid;
  List<ChatMessageModel> messages;

  ChatModel({
    required this.uid,
    required this.currentUserUid,
    required this.messages,
  }) {
    
  }
}
