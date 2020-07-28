// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.totalReceived,
    this.totalPaid,
    this.payments,
    this.paymentsWidget,
    this.user,
  });

  Total totalReceived;
  Total totalPaid;
  List<dynamic> payments;
  PaymentsWidget paymentsWidget;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalReceived: Total.fromJson(json["total_received"]),
        totalPaid: Total.fromJson(json["total_paid"]),
        payments: List<dynamic>.from(json["payments"].map((x) => x)),
        paymentsWidget: PaymentsWidget.fromJson(json["payments_widget"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "total_received": totalReceived.toJson(),
        "total_paid": totalPaid.toJson(),
        "payments": List<dynamic>.from(payments.map((x) => x)),
        "payments_widget": paymentsWidget.toJson(),
        "user": user.toJson(),
      };
}

class PaymentsWidget {
  PaymentsWidget({
    this.state,
    this.loan,
    this.application,
    this.disbursingState,
    this.widget,
  });

  String state;
  dynamic loan;
  Application application;
  String disbursingState;
  Widget widget;

  factory PaymentsWidget.fromJson(Map<String, dynamic> json) => PaymentsWidget(
        state: json["state"],
        loan: json["loan"],
        application: Application.fromJson(json["application"]),
        disbursingState: json["disbursingState"],
        widget: Widget.fromJson(json["widget"]),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "loan": loan,
        "application": application.toJson(),
        "disbursingState": disbursingState,
        "widget": widget.toJson(),
      };
}

class Application {
  Application({
    this.state,
    this.amountRequested,
    this.amountApproved,
    this.amountAllowed,
    this.thresholdDate,
    this.errorsCount,
  });

  String state;
  AmountRequested amountRequested;
  dynamic amountApproved;
  dynamic amountAllowed;
  dynamic thresholdDate;
  dynamic errorsCount;

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        state: json["state"],
        amountRequested: AmountRequested.fromJson(json["amountRequested"]),
        amountApproved: json["amountApproved"],
        amountAllowed: json["amountAllowed"],
        thresholdDate: json["thresholdDate"],
        errorsCount: json["errorsCount"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "amountRequested": amountRequested.toJson(),
        "amountApproved": amountApproved,
        "amountAllowed": amountAllowed,
        "thresholdDate": thresholdDate,
        "errorsCount": errorsCount,
      };
}

class AmountRequested {
  AmountRequested({
    this.formatted,
    this.formattedInDecimals,
    this.value,
  });

  String formatted;
  String formattedInDecimals;
  int value;

  factory AmountRequested.fromJson(Map<String, dynamic> json) =>
      AmountRequested(
        formatted: json["formatted"],
        formattedInDecimals: json["formattedInDecimals"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "formatted": formatted,
        "formattedInDecimals": formattedInDecimals,
        "value": value,
      };
}

class Widget {
  Widget({
    this.title,
    this.text,
    this.buttons,
    this.modals,
  });

  dynamic title;
  String text;
  List<Button> buttons;
  dynamic modals;

  factory Widget.fromJson(Map<String, dynamic> json) => Widget(
        title: json["title"],
        text: json["text"],
        buttons:
            List<Button>.from(json["buttons"].map((x) => Button.fromJson(x))),
        modals: json["modals"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "buttons": List<dynamic>.from(buttons.map((x) => x.toJson())),
        "modals": modals,
      };
}

class Button {
  Button({
    this.action,
    this.label,
    this.disabled,
  });

  String action;
  String label;
  bool disabled;

  factory Button.fromJson(Map<String, dynamic> json) => Button(
        action: json["action"],
        label: json["label"],
        disabled: json["disabled"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "label": label,
        "disabled": disabled,
      };
}

class Total {
  Total({
    this.formatted,
    this.formattedWithDecimals,
    this.value,
  });

  String formatted;
  String formattedWithDecimals;
  int value;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        formatted: json["formatted"],
        formattedWithDecimals: json["formatted_with_decimals"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "formatted": formatted,
        "formatted_with_decimals": formattedWithDecimals,
        "value": value,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.bvn,
    this.bankId,
    this.accountName,
    this.accountNumber,
    this.gender,
    this.dob,
    this.isBanned,
    this.scoresAmount,
    this.scoresUpdatedAt,
  });

  String id;
  String name;
  String email;
  String phone;
  String role;
  String bvn;
  String bankId;
  String accountName;
  String accountNumber;
  String gender;
  DateTime dob;
  bool isBanned;
  int scoresAmount;
  DateTime scoresUpdatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        bvn: json["bvn"],
        bankId: json["bank_id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        isBanned: json["is_banned"],
        scoresAmount: json["scores_amount"],
        scoresUpdatedAt: DateTime.parse(json["scores_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "bvn": bvn,
        "bank_id": bankId,
        "account_name": accountName,
        "account_number": accountNumber,
        "gender": gender,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "is_banned": isBanned,
        "scores_amount": scoresAmount,
        "scores_updated_at": scoresUpdatedAt.toIso8601String(),
      };
}
