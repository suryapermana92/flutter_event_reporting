// To parse this JSON data, do
//
//     final segnalazionList = segnalazionListFromJson(jsonString);

import 'dart:convert';

SegnalazionList segnalazionListFromJson(String str) =>
    SegnalazionList.fromJson(json.decode(str));

String segnalazionListToJson(SegnalazionList data) =>
    json.encode(data.toJson());

class SegnalazionList {
  SegnalazionList({
    this.data,
    this.totRows,
  });

  List<SegnalazioniListData> data;
  int totRows;

  factory SegnalazionList.fromJson(Map<String, dynamic> json) =>
      SegnalazionList(
        data: List<SegnalazioniListData>.from(
            json["data"].map((x) => SegnalazioniListData.fromJson(x))),
        totRows: json["totRows"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totRows": totRows,
      };
}

class SegnalazioniListData {
  SegnalazioniListData({
    this.id,
    this.canale,
    this.dtTelefonata,
    this.dtCreazione,
    this.dtArchiviazione,
    this.dtSalvataggio,
    this.dtArchiviazionePi,
    this.stato,
    this.archiviataPi,
    this.richiedenteTipologia,
    this.richiedenteStrutturaId,
    this.richiedenteNominativoCognome,
    this.richiedenteNominativoNome,
    this.richiedenteEmail,
    this.richiedenteTelefono,
    this.richiedenteCivico,
    this.richiedenteIndirizzo,
    this.richiedenteComune,
    this.eventoComune,
    this.eventoIndirizzo1,
    this.eventoCivico1,
    this.eventoIndirizzo2,
    this.eventoCivico2,
    this.eventoUbicazione,
    this.eventoCoordinateLat,
    this.eventoCoordinateLon,
    this.eventoCoordinateBaseLat,
    this.eventoCoordinateBaseLon,
    this.eventoCoordinateCertificato,
    this.lastUfficiStato,
    this.dettaglioJson,
    this.descrizione,
    this.codiceEsitoSegnalazione,
    this.del,
    this.correlatoId,
    this.idTipologieSegnalazioni,
    this.idOperatoreArchiviazione,
    this.idOperatoreArchiviazionePi,
    this.idOperatoreCreazione,
    this.idOperatoreSalvataggio,
    this.idRichiedentePattugliaOperatore1,
    this.idRichiedentePattugliaOperatore2,
    this.idRichiedentePattugliaOperatore3,
    this.idRichiedentePattugliaOperatore4,
    this.idJson,
    this.eventoZona,
  });

  int id;
  int canale;
  dynamic dtTelefonata;
  DateTime dtCreazione;
  dynamic dtArchiviazione;
  DateTime dtSalvataggio;
  dynamic dtArchiviazionePi;
  String stato;
  int archiviataPi;
  dynamic richiedenteTipologia;
  dynamic richiedenteStrutturaId;
  String richiedenteNominativoCognome;
  String richiedenteNominativoNome;
  String richiedenteEmail;
  String richiedenteTelefono;
  String richiedenteCivico;
  String richiedenteIndirizzo;
  String richiedenteComune;
  String eventoComune;
  String eventoIndirizzo1;
  String eventoCivico1;
  String eventoIndirizzo2;
  String eventoCivico2;
  String eventoUbicazione;
  double eventoCoordinateLat;
  double eventoCoordinateLon;
  int eventoCoordinateBaseLat;
  int eventoCoordinateBaseLon;
  int eventoCoordinateCertificato;
  dynamic lastUfficiStato;
  dynamic dettaglioJson;
  dynamic descrizione;
  dynamic codiceEsitoSegnalazione;
  int del;
  dynamic correlatoId;
  int idTipologieSegnalazioni;
  dynamic idOperatoreArchiviazione;
  dynamic idOperatoreArchiviazionePi;
  int idOperatoreCreazione;
  int idOperatoreSalvataggio;
  dynamic idRichiedentePattugliaOperatore1;
  dynamic idRichiedentePattugliaOperatore2;
  dynamic idRichiedentePattugliaOperatore3;
  dynamic idRichiedentePattugliaOperatore4;
  dynamic idJson;
  String eventoZona;

  factory SegnalazioniListData.fromJson(Map<String, dynamic> json) =>
      SegnalazioniListData(
        id: json["id"],
        canale: json["canale"],
        dtTelefonata: json["dt_telefonata"],
        dtCreazione: DateTime.parse(json["dt_creazione"]),
        dtArchiviazione: json["dt_archiviazione"],
        dtSalvataggio: DateTime.parse(json["dt_salvataggio"]),
        dtArchiviazionePi: json["dt_archiviazione_pi"],
        stato: json["stato"],
        archiviataPi: json["archiviata_pi"],
        richiedenteTipologia: json["richiedente_tipologia"],
        richiedenteStrutturaId: json["richiedente_struttura_id"],
        richiedenteNominativoCognome: json["richiedente_nominativo_cognome"],
        richiedenteNominativoNome: json["richiedente_nominativo_nome"],
        richiedenteEmail: json["richiedente_email"],
        richiedenteTelefono: json["richiedente_telefono"],
        richiedenteCivico: json["richiedente_civico"],
        richiedenteIndirizzo: json["richiedente_indirizzo"],
        richiedenteComune: json["richiedente_comune"],
        eventoComune: json["evento_comune"],
        eventoIndirizzo1: json["evento_indirizzo1"],
        eventoCivico1: json["evento_civico1"],
        eventoIndirizzo2: json["evento_indirizzo2"],
        eventoCivico2: json["evento_civico2"],
        eventoUbicazione: json["evento_ubicazione"],
        eventoCoordinateLat: json["evento_coordinate_lat"].toDouble(),
        eventoCoordinateLon: json["evento_coordinate_lon"].toDouble(),
        eventoCoordinateBaseLat: json["evento_coordinate_base_lat"],
        eventoCoordinateBaseLon: json["evento_coordinate_base_lon"],
        eventoCoordinateCertificato: json["evento_coordinate_certificato"],
        lastUfficiStato: json["last_uffici_stato"],
        dettaglioJson: json["dettaglio_json"],
        descrizione: json["descrizione"],
        codiceEsitoSegnalazione: json["codice_esito_segnalazione"],
        del: json["del"],
        correlatoId: json["correlato_id"],
        idTipologieSegnalazioni: json["id_tipologie_segnalazioni"],
        idOperatoreArchiviazione: json["id_operatore_archiviazione"],
        idOperatoreArchiviazionePi: json["id_operatore_archiviazione_pi"],
        idOperatoreCreazione: json["id_operatore_creazione"],
        idOperatoreSalvataggio: json["id_operatore_salvataggio"],
        idRichiedentePattugliaOperatore1:
            json["id_richiedente_pattuglia_operatore_1"],
        idRichiedentePattugliaOperatore2:
            json["id_richiedente_pattuglia_operatore_2"],
        idRichiedentePattugliaOperatore3:
            json["id_richiedente_pattuglia_operatore_3"],
        idRichiedentePattugliaOperatore4:
            json["id_richiedente_pattuglia_operatore_4"],
        idJson: json["id_json"],
        eventoZona: json["evento_zona"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "canale": canale,
        "dt_telefonata": dtTelefonata,
        "dt_creazione": dtCreazione.toIso8601String(),
        "dt_archiviazione": dtArchiviazione,
        "dt_salvataggio": dtSalvataggio.toIso8601String(),
        "dt_archiviazione_pi": dtArchiviazionePi,
        "stato": stato,
        "archiviata_pi": archiviataPi,
        "richiedente_tipologia": richiedenteTipologia,
        "richiedente_struttura_id": richiedenteStrutturaId,
        "richiedente_nominativo_cognome": richiedenteNominativoCognome,
        "richiedente_nominativo_nome": richiedenteNominativoNome,
        "richiedente_email": richiedenteEmail,
        "richiedente_telefono": richiedenteTelefono,
        "richiedente_civico": richiedenteCivico,
        "richiedente_indirizzo": richiedenteIndirizzo,
        "richiedente_comune": richiedenteComune,
        "evento_comune": eventoComune,
        "evento_indirizzo1": eventoIndirizzo1,
        "evento_civico1": eventoCivico1,
        "evento_indirizzo2": eventoIndirizzo2,
        "evento_civico2": eventoCivico2,
        "evento_ubicazione": eventoUbicazione,
        "evento_coordinate_lat": eventoCoordinateLat,
        "evento_coordinate_lon": eventoCoordinateLon,
        "evento_coordinate_base_lat": eventoCoordinateBaseLat,
        "evento_coordinate_base_lon": eventoCoordinateBaseLon,
        "evento_coordinate_certificato": eventoCoordinateCertificato,
        "last_uffici_stato": lastUfficiStato,
        "dettaglio_json": dettaglioJson,
        "descrizione": descrizione,
        "codice_esito_segnalazione": codiceEsitoSegnalazione,
        "del": del,
        "correlato_id": correlatoId,
        "id_tipologie_segnalazioni": idTipologieSegnalazioni,
        "id_operatore_archiviazione": idOperatoreArchiviazione,
        "id_operatore_archiviazione_pi": idOperatoreArchiviazionePi,
        "id_operatore_creazione": idOperatoreCreazione,
        "id_operatore_salvataggio": idOperatoreSalvataggio,
        "id_richiedente_pattuglia_operatore_1":
            idRichiedentePattugliaOperatore1,
        "id_richiedente_pattuglia_operatore_2":
            idRichiedentePattugliaOperatore2,
        "id_richiedente_pattuglia_operatore_3":
            idRichiedentePattugliaOperatore3,
        "id_richiedente_pattuglia_operatore_4":
            idRichiedentePattugliaOperatore4,
        "id_json": idJson,
        "evento_zona": eventoZona,
      };
}
