class NotificationMarkAllRead {
  final int status;
  final bool? error;
  final String message;
  final Data data;
  NotificationMarkAllRead(
      {required this.status,
      required this.error,
      required this.message,
      required this.data});

  factory NotificationMarkAllRead.fromJson(Map<String, dynamic> json) {
    return NotificationMarkAllRead(
        status: json['status'],
        error: json['error'],
        message: json['message'],
        data: Data.fromJson(json['data']));
  }
}

class Data {
  final int modifiedCount;
  Data({required this.modifiedCount});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(modifiedCount: json['modifiedCount']);
  }

  Map<String, dynamic> toJson() {
    return {'modifiedCount': modifiedCount};
  }
}
