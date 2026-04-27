class ChatModel {
  int? status;
  String? message;
  
  List<Data>? data;

  ChatModel({this.status, this.message, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(  Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] =  status;
    data['message'] =  message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? rideid;
  String? senderId;
  String? receiverId;
  String? chatData;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? senderFirstName;
  String? senderLastName;
  String? receiverFirstName;
  String? receiverLastName;
  dynamic chateDate;

  Data(
      {this.sId,
      this.rideid,
      this.senderId,
      this.receiverId,
      this.chatData,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.senderFirstName,
      this.senderLastName,
      this.receiverFirstName,
      this.receiverLastName,
      this.chateDate});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rideid = json['rideid'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    chatData = json['chatData'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    senderFirstName = json['senderFirstName'];
    senderLastName = json['senderLastName'];
    receiverFirstName = json['receiverFirstName'];
    receiverLastName = json['receiverLastName'];
    chateDate = json['chateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['_id'] =  sId;
    data['rideid'] = rideid;
    data['senderId'] =  senderId;
    data['receiverId'] =  receiverId;
    data['chatData'] =  chatData;
    data['status'] =  status;
    data['createdAt'] =  createdAt;
    data['updatedAt'] =  updatedAt;
    data['__v'] = iV;
    data['senderFirstName'] = senderFirstName;
    data['senderLastName'] =  senderLastName;
    data['receiverFirstName'] =  receiverFirstName;
    data['receiverLastName'] =  receiverLastName;
    data['chateDate'] = chateDate;
    return data;
  }
}