class ChatModelDec {
  String? rideid;
  String? senderId;
  String? receiverId;
  String? messages;

  ChatModelDec({this.rideid, this.senderId, this.receiverId, this.messages});

  ChatModelDec.fromJson(Map<String, dynamic> json) {
    rideid = json['rideid'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['rideid'] = rideid;
    data['senderId'] =  senderId;
    data['receiverId'] =  receiverId;
    data['messages'] = messages;
    return data;
  }
}