// To parse this JSON data, do
//
//     final segnalazioni = segnalazioniFromJson(jsonString);

import 'dart:convert';

Segnalazioni segnalazioniFromJson(String str) =>
    Segnalazioni.fromJson(json.decode(str));

String segnalazioniToJson(Segnalazioni data) => json.encode(data.toJson());

class Segnalazioni {
  Segnalazioni({
    this.richiedenteNominativoNome,
    this.richiedenteNominativoCognome,
    this.richiedenteEmail,
    this.richiedenteTelefono,
    this.eventoIndirizzo1,
    this.eventoCivico1,
    this.eventoComune,
    this.eventoUbicazione,
    this.eventoCoordinateLat,
    this.eventoCoordinateLon,
    this.idTipologieSegnalazioni,
  });

  String richiedenteNominativoNome;
  String richiedenteNominativoCognome;
  String richiedenteEmail;
  String richiedenteTelefono;
  String eventoIndirizzo1;
  String eventoCivico1;
  String eventoComune;
  String eventoUbicazione;
  double eventoCoordinateLat;
  double eventoCoordinateLon;
  int idTipologieSegnalazioni;

  factory Segnalazioni.fromJson(Map<String, dynamic> json) => Segnalazioni(
        richiedenteNominativoNome: json["richiedente_nominativo_nome"],
        richiedenteNominativoCognome: json["richiedente_nominativo_cognome"],
        richiedenteEmail: json["richiedente_email"],
        richiedenteTelefono: json["richiedente_telefono"],
        eventoIndirizzo1: json["evento_indirizzo1"],
        eventoCivico1: json["evento_civico1"],
        eventoComune: json["evento_comune"],
        eventoUbicazione: json["evento_ubicazione"],
        eventoCoordinateLat: json["evento_coordinate_lat"].toDouble(),
        eventoCoordinateLon: json["evento_coordinate_lon"].toDouble(),
        idTipologieSegnalazioni: json["id_tipologie_segnalazioni"],
      );

  Map<String, dynamic> toJson() => {
        "richiedente_nominativo_nome": richiedenteNominativoNome,
        "richiedente_nominativo_cognome": richiedenteNominativoCognome,
        "richiedente_email": richiedenteEmail,
        "richiedente_telefono": richiedenteTelefono,
        "evento_indirizzo1": eventoIndirizzo1,
        "evento_civico1": eventoCivico1,
        "evento_comune": eventoComune,
        "evento_ubicazione": eventoUbicazione,
        "evento_coordinate_lat": eventoCoordinateLat,
        "evento_coordinate_lon": eventoCoordinateLon,
        "id_tipologie_segnalazioni": idTipologieSegnalazioni,
      };
}
