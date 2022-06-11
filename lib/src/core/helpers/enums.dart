/// Packages values.
// ignore_for_file: constant_identifier_names, public_member_api_docs

enum PackagingUnit {
  AMPOULE('AM'),
  BARREL('BA'),
  BOTTLECRATE('BC'),
  BUNDLE('BE'),
  NONPROTECTEDBALLOON('BF'),
  BAG('BG'),
  BUCKET('BJ'),
  BASKET('BK'),
  BALE('BL'),
  PROTECTEDBOTTLE('BQ'),
  BAR('BR'),
  BULBOUSBOTTLE('BV'),
  CAN('CA'),
  CHEST('CH'),
  COFFIN('CJ'),
  COIL('CL'),
  WOODENBOX('CR'),
  CASSETTE('CS'),
  CARTON('CT'),
  CONTAINER('CTN'),
  CYLINDER('CY'),
  DRUM('DR'),
  EXTRACOUNTABLEITEM('GT'),
  HANDBAGGAGE('HH'),
  INGOTS('IZ'),
  JAR('JR'),
  JUG('JU'),
  JERRYCANCYLINDRICAL('JY'),
  CANESTER('KZ'),
  LOGS('LZ'),
  NET('NT'),
  NONEXTERIORPACKAGING('OU'),
  PODDON('PD'),
  PLATE('PG'),
  PIPE('PI'),
  PILOT('PO'),
  TRAYPACK('PU'),
  REEL('RL'),
  ROLL('RO'),
  RODS('RZ'),
  SKELETONCASE('SK'),
  TANK('TY'),
  MILLS('ML'),
  TAN('TN'),
  BULKGAS('VG'),
  BULKGASATABNORMALTEMPERATURE('VQ'),
  BULKLIQUIDATNORMALTEMPERATURE('VL'),
  BULKSOLIDLARGEPARTICLES('VO'),
  BULKSOLIDGRANULARPARTICLES('VR'),
  BULKSOLIDFINEPARTICLES('VY'),
  BULKEXTRAITEM('VT');

  const PackagingUnit(this.value);
  final String value;
}

/// Supported Payment methods.
enum PaymentMethod {
  /// Payment by cash.
  CASH(1),

  /// Payment by credit.
  CREDIT(2),

  /// Payment by cash credit.
  CASHCREDIT(3),

  /// Payment by a bank check.
  BANKCHECK(4),

  /// Payment by a Debit or Credit card.
  DEBITCREDITCARD(5),

  /// Payment by Mobile money.
  MOBILEMONEY(6),

  /// Other types of payment.
  OTHER(7);

  const PaymentMethod(this.value);
  final int value;
}

enum ProductType {
  RAW(1),
  PRODUCT(2),
  SERVICE(3);

  const ProductType(this.value);
  final int value;
}

/// The type of receipt for a certain purchase.
enum PurchaseReceiptType {
  PURCHASE('P'),
  REFUND('R');

  const PurchaseReceiptType(this.value);
  final String value;
}

enum QuantityUnit {
  CAP('AV'),
  BARREL('BA'),
  BUNDLE('BE'),
  BAG('BG'),
  BLOCK('BL'),
  BOX('BX'),
  CAN('CA'),
  CELL('CEL'),
  CENTIMETRE('CMT'),
  CARAT('CR'),
  DRUM('DR'),
  DOZEN('DZ'),
  GALLON('GLL'),
  GRAM('GRM'),
  GROSS('GRO'),
  KILOGRAMME('KG'),
  KILOMETRE('KTM'),
  KILOWATT('KWT'),
  LITRE('L'),
  POUND('LBR'),
  LINK('LK'),
  METRE('M'),
  SQUAREMETRE('M2'),
  CUBICMETRE('M3'),
  MILLIGRAM('MGM'),
  MEGAWATTHOUR('MWT'),
  NUMBER('NO'),
  PARTPERTHOUSAND('NX'),
  PACKET('PA'),
  PLATE('PG'),
  PAIR('PR'),
  REEL('RL'),
  ROLL('RO'),
  SET('SET'),
  SHEET('ST'),
  TONNE('TNE'),
  TUBE('TU'),
  ITEM('U'),
  YARD('YRD');

  const QuantityUnit(this.value);

  final String value;
}

enum RegistrationType {
  AUTOMATIC('A'),
  MANUAL('M');

  const RegistrationType(this.value);
  final String value;
}

enum SaleReceiptType {
  SALE('S'),
  REFUND('R');

  const SaleReceiptType(this.value);
  final String value;
}

enum StockType {
  IMPORT(01),
  PURCHASE(02),
  RETURN(03),
  STOCKMOVEMENT(04),
  PROCESSING(05),
  ADJUSTMENT(06),
  SALE(11);
  // RETURN(12),
  // STOCKMOVEMENT(13),
  // PROCESSING(14);
  // ADJUSTMENT(16);

  const StockType(this.value);
  final int value;
}

enum TransactionType {
  COPY('C'),
  NORMAL('N'),
  PROFORMA('P'),
  TRAINING('T');

  const TransactionType(this.value);
  final String value;
}

enum TaxStatus {
  ACTIVE('A'),
  DISCARD('D');

  const TaxStatus(this.value);
  final String value;
}

enum TaxType {
  A('A-EX'),
  B('B-18%'),
  C('C'),
  D('D');

  const TaxType(this.value);
  final String value;
}

enum TransactionProgress {
  WAITAPPROVAL(01),
  APPROVED(02),
  CANCELREQUESTED(03),
  CANCELED(04),
  REFUNDED(05),
  TRANSFERRED(06);

  const TransactionProgress(this.value);

  final int value;
}
