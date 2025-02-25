class WarrantyListModel {
  int? count;
  Null? next;
  Null? previous;
  String? status;
  String? message;
  List<WarrantyData>? data;

  WarrantyListModel(
      {this.count,
      this.next,
      this.previous,
      this.status,
      this.message,
      this.data});

  WarrantyListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    status = json['status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = <WarrantyData>[];
      json['data'].forEach((v) {
        data!.add(new WarrantyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarrantyData {
  int? id;
  String? serialNumber;
  String? invoice;
  String? model;
  String? chno;
  String? motor;
  String? controller;
  String? charge;
  String? batteryNo;
  String? customerName;
  String? address;
  int? phoneNumber;
  String? purchaseDate;
  String? type;
  String? email;
  String? remark;
  String? createdAt;

  WarrantyData(
      {this.id,
      this.serialNumber,
      this.invoice,
      this.model,
      this.chno,
      this.motor,
      this.controller,
      this.charge,
      this.batteryNo,
      this.customerName,
      this.address,
      this.phoneNumber,
      this.purchaseDate,
      this.type,
      this.remark,
        this.email,
      this.createdAt});

  WarrantyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    invoice = json['invoice'];
    model = json['model'];
    chno = json['chno'];
    motor = json['motor'];
    controller = json['controller'];
    charge = json['charge'];
    batteryNo = json['battery_no'];
    customerName = json['customer_name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    purchaseDate = json['purchase_date'];
    type = json['type'];
    remark = json['remark'];
    email = json['null'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_number'] = this.serialNumber;
    data['invoice'] = this.invoice;
    data['model'] = this.model;
    data['chno'] = this.chno;
    data['motor'] = this.motor;
    data['controller'] = this.controller;
    data['charge'] = this.charge;
    data['battery_no'] = this.batteryNo;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['purchase_date'] = this.purchaseDate;
    data['type'] = this.type;
    data['remark'] = this.remark;
    data['email'] = this.remark;
    data['created_at'] = this.createdAt;
    return data;
  }
}
