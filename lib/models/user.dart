// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.exp,
    this.nbf,
    this.iat,
    this.utente,
    this.codicecliente,
  });

  final int exp;
  final int nbf;
  final int iat;
  final Utente utente;
  final String codicecliente;

  User copyWith({
    int exp,
    int nbf,
    int iat,
    Utente utente,
    String codicecliente,
  }) =>
      User(
        exp: exp ?? this.exp,
        nbf: nbf ?? this.nbf,
        iat: iat ?? this.iat,
        utente: utente ?? this.utente,
        codicecliente: codicecliente ?? this.codicecliente,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        exp: json["exp"] == null ? null : json["exp"],
        nbf: json["nbf"] == null ? null : json["nbf"],
        iat: json["iat"] == null ? null : json["iat"],
        utente: json["utente"] == null ? null : Utente.fromJson(json["utente"]),
        codicecliente:
            json["codicecliente"] == null ? null : json["codicecliente"],
      );

  Map<String, dynamic> toJson() => {
        "exp": exp == null ? null : exp,
        "nbf": nbf == null ? null : nbf,
        "iat": iat == null ? null : iat,
        "utente": utente == null ? null : utente.toJson(),
        "codicecliente": codicecliente == null ? null : codicecliente,
      };
}

class Utente {
  Utente({
    this.id,
    this.username,
    this.password,
    this.cognome,
    this.privilegi,
    this.nome,
    this.email,
    this.dtCreazione,
    this.idOperatoreCreazione,
    this.dtSalvataggio,
    this.idOperatoreSalvataggio,
    this.dtCancellazione,
    this.idOperatoreCancellazione,
    this.privilegiArray,
  });

  final int id;
  final String username;
  final String password;
  final String cognome;
  final String privilegi;
  final String nome;
  final String email;
  final String dtCreazione;
  final int idOperatoreCreazione;
  final DateTime dtSalvataggio;
  final int idOperatoreSalvataggio;
  final dynamic dtCancellazione;
  final dynamic idOperatoreCancellazione;
  final List<PrivilegiArray> privilegiArray;

  Utente copyWith({
    int id,
    String username,
    String password,
    String cognome,
    String privilegi,
    String nome,
    String email,
    String dtCreazione,
    int idOperatoreCreazione,
    DateTime dtSalvataggio,
    int idOperatoreSalvataggio,
    dynamic dtCancellazione,
    dynamic idOperatoreCancellazione,
    List<PrivilegiArray> privilegiArray,
  }) =>
      Utente(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        cognome: cognome ?? this.cognome,
        privilegi: privilegi ?? this.privilegi,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        dtCreazione: dtCreazione ?? this.dtCreazione,
        idOperatoreCreazione: idOperatoreCreazione ?? this.idOperatoreCreazione,
        dtSalvataggio: dtSalvataggio ?? this.dtSalvataggio,
        idOperatoreSalvataggio:
            idOperatoreSalvataggio ?? this.idOperatoreSalvataggio,
        dtCancellazione: dtCancellazione ?? this.dtCancellazione,
        idOperatoreCancellazione:
            idOperatoreCancellazione ?? this.idOperatoreCancellazione,
        privilegiArray: privilegiArray ?? this.privilegiArray,
      );

  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        cognome: json["cognome"] == null ? null : json["cognome"],
        privilegi: json["privilegi"] == null ? null : json["privilegi"],
        nome: json["nome"] == null ? null : json["nome"],
        email: json["email"] == null ? null : json["email"],
        dtCreazione: json["dt_creazione"] == null ? null : json["dt_creazione"],
        idOperatoreCreazione: json["id_operatore_creazione"] == null
            ? null
            : json["id_operatore_creazione"],
        dtSalvataggio: json["dt_salvataggio"] == null
            ? null
            : DateTime.parse(json["dt_salvataggio"]),
        idOperatoreSalvataggio: json["id_operatore_salvataggio"] == null
            ? null
            : json["id_operatore_salvataggio"],
        dtCancellazione: json["dt_cancellazione"],
        idOperatoreCancellazione: json["id_operatore_cancellazione"],
        privilegiArray: json["privilegi_array"] == null
            ? null
            : List<PrivilegiArray>.from(
                json["privilegi_array"].map((x) => PrivilegiArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "cognome": cognome == null ? null : cognome,
        "privilegi": privilegi == null ? null : privilegi,
        "nome": nome == null ? null : nome,
        "email": email == null ? null : email,
        "dt_creazione": dtCreazione == null ? null : dtCreazione,
        "id_operatore_creazione":
            idOperatoreCreazione == null ? null : idOperatoreCreazione,
        "dt_salvataggio":
            dtSalvataggio == null ? null : dtSalvataggio.toIso8601String(),
        "id_operatore_salvataggio":
            idOperatoreSalvataggio == null ? null : idOperatoreSalvataggio,
        "dt_cancellazione": dtCancellazione,
        "id_operatore_cancellazione": idOperatoreCancellazione,
        "privilegi_array": privilegiArray == null
            ? null
            : List<dynamic>.from(privilegiArray.map((x) => x.toJson())),
      };
}

class PrivilegiArray {
  PrivilegiArray({
    this.codice,
    this.attivo,
  });

  final String codice;
  final bool attivo;

  PrivilegiArray copyWith({
    String codice,
    bool attivo,
  }) =>
      PrivilegiArray(
        codice: codice ?? this.codice,
        attivo: attivo ?? this.attivo,
      );

  factory PrivilegiArray.fromJson(Map<String, dynamic> json) => PrivilegiArray(
        codice: json["codice"] == null ? null : json["codice"],
        attivo: json["attivo"] == null ? null : json["attivo"],
      );

  Map<String, dynamic> toJson() => {
        "codice": codice == null ? null : codice,
        "attivo": attivo == null ? null : attivo,
      };
}
