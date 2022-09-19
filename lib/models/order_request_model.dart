class OrderRequestModel {
  final String orderName;
  final String buyersAddress;
  OrderRequestModel({
    required this.orderName,
    required this.buyersAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderName': orderName,
      'buyersAddress': buyersAddress,
    };
  }

  factory OrderRequestModel.fromMap({required Map<String, dynamic> map}) {
    return OrderRequestModel(
      orderName: map['orderName'] as String,
      buyersAddress: map['buyersAddress'] as String,
    );
  }
}
