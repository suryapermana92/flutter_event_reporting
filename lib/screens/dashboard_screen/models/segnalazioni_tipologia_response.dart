// To parse this JSON data, do
//
//     final segnalazionTipologiaResponse = segnalazionTipologiaResponseFromJson(jsonString);

import 'dart:convert';

SegnalazionTipologiaResponse segnalazionTipologiaResponseFromJson(String str) =>
    SegnalazionTipologiaResponse.fromJson(json.decode(str));

String segnalazionTipologiaResponseToJson(SegnalazionTipologiaResponse data) =>
    json.encode(data.toJson());

class SegnalazionTipologiaResponse {
  SegnalazionTipologiaResponse({
    this.data,
    this.totRows,
  });

  List<SegnalazionTipologiaData> data;
  int totRows;

  factory SegnalazionTipologiaResponse.fromJson(Map<String, dynamic> json) =>
      SegnalazionTipologiaResponse(
        data: List<SegnalazionTipologiaData>.from(
            json["data"].map((x) => SegnalazionTipologiaData.fromJson(x))),
        totRows: json["totRows"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totRows": totRows,
      };
}

class SegnalazionTipologiaData {
  SegnalazionTipologiaData({
    this.id,
    this.descrizione,
  });

  int id;
  String descrizione;

  factory SegnalazionTipologiaData.fromJson(Map<String, dynamic> json) =>
      SegnalazionTipologiaData(
        id: json["id"],
        descrizione: json["descrizione"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descrizione": descrizione,
      };
}
