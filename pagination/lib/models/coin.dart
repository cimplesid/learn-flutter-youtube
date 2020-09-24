class Coin {
  Coin({
    this.data,
    this.info,
  });

  List<Datum> data;
  Info info;

  static Coin fromMap(Map<String, dynamic> json) => Coin(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        info: Info.fromMap(json["info"]),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "info": info.toMap(),
      };
}

class Datum {
  Datum({
    this.id,
    this.symbol,
    this.name,
    this.nameid,
    this.rank,
    this.priceUsd,
    this.percentChange24H,
    this.percentChange1H,
    this.percentChange7D,
    this.priceBtc,
    this.marketCapUsd,
    this.volume24,
    this.volume24A,
    this.csupply,
    this.tsupply,
    this.msupply,
  });

  String id;
  String symbol;
  String name;
  String nameid;
  int rank;
  String priceUsd;
  String percentChange24H;
  String percentChange1H;
  String percentChange7D;
  String priceBtc;
  String marketCapUsd;
  double volume24;
  double volume24A;
  String csupply;
  String tsupply;
  String msupply;

  static Datum fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        nameid: json["nameid"],
        rank: json["rank"],
        priceUsd: json["price_usd"],
        percentChange24H: json["percent_change_24h"],
        percentChange1H: json["percent_change_1h"],
        percentChange7D: json["percent_change_7d"],
        priceBtc: json["price_btc"],
        marketCapUsd: json["market_cap_usd"],
        volume24: json["volume24"].toDouble(),
        volume24A: json["volume24a"].toDouble(),
        csupply: json["csupply"],
        tsupply: json["tsupply"],
        msupply: json["msupply"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "nameid": nameid,
        "rank": rank,
        "price_usd": priceUsd,
        "percent_change_24h": percentChange24H,
        "percent_change_1h": percentChange1H,
        "percent_change_7d": percentChange7D,
        "price_btc": priceBtc,
        "market_cap_usd": marketCapUsd,
        "volume24": volume24,
        "volume24a": volume24A,
        "csupply": csupply,
        "tsupply": tsupply,
        "msupply": msupply,
      };
}

class Info {
  Info({
    this.coinsNum,
    this.time,
  });

  int coinsNum;
  int time;

  static Info fromMap(Map<String, dynamic> json) => Info(
        coinsNum: json["coins_num"],
        time: json["time"],
      );

  Map<String, dynamic> toMap() => {
        "coins_num": coinsNum,
        "time": time,
      };
}
