class PropertyModel {
  final String id;
  final String ownerName;
  final String status; // "محجوز", "معروض", "مؤجر"
  final String address;
  final double price;

  PropertyModel({
    required this.id,
    required this.ownerName,
    required this.status,
    required this.address,
    required this.price,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      ownerName: json['owner_name'],
      status: json['status'],
      address: json['address'],
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_name': ownerName,
      'status': status,
      'address': address,
      'price': price,
    };
  }
}