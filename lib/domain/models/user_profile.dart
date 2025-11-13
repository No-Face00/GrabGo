class UserProfile {
  UserProfile({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.customerCity,
    required this.customerState,
    required this.customerPostcode,
    required this.customerCountry,
    required this.customerPhone,
    required this.customerFax,
    required this.shippingName,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPostcode,
    required this.shippingCountry,
    required this.shippingPhone,
    required this.userId,
    required this.email,
  });

  final int id;
  final String customerName;
  final String customerAddress;
  final String customerCity;
  final String customerState;
  final String customerPostcode;
  final String customerCountry;
  final String customerPhone;
  final String customerFax;
  final String shippingName;
  final String shippingAddress;
  final String shippingCity;
  final String shippingState;
  final String shippingPostcode;
  final String shippingCountry;
  final String shippingPhone;
  final int userId;
  final String email;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? user = json['user'] as Map<String, dynamic>?;
    return UserProfile(
      id: (json['id'] ?? 0) as int,
      customerName: (json['cus_name'] ?? '') as String,
      customerAddress: (json['cus_add'] ?? '') as String,
      customerCity: (json['cus_city'] ?? '') as String,
      customerState: (json['cus_state'] ?? '') as String,
      customerPostcode: (json['cus_postcode'] ?? '') as String,
      customerCountry: (json['cus_country'] ?? '') as String,
      customerPhone: (json['cus_phone'] ?? '') as String,
      customerFax: (json['cus_fax'] ?? '') as String,
      shippingName: (json['ship_name'] ?? '') as String,
      shippingAddress: (json['ship_add'] ?? '') as String,
      shippingCity: (json['ship_city'] ?? '') as String,
      shippingState: (json['ship_state'] ?? '') as String,
      shippingPostcode: (json['ship_postcode'] ?? '') as String,
      shippingCountry: (json['ship_country'] ?? '') as String,
      shippingPhone: (json['ship_phone'] ?? '') as String,
      userId: (json['user_id'] ?? 0) as int,
      email: (user != null ? (user['email'] ?? '') : '') as String,
    );
  }
}
