class PushNotificationMessage {
  final String userId;
  final String title;
  final String body;

  PushNotificationMessage({
    required this.userId,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMessage() {
    return {
      'token': userId,
      'notification': {
        'title': title,
        'body': body,
      },
      'data': {
        // Optional data to include with the notification
      },
    };
  }
}
