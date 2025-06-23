// model/seller_model.dart
class SellerModel {
  final String sellerId;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final double rating;
  final int totalReviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SellerModel({
    required this.sellerId,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor untuk membuat SellerModel dari Map (Firestore data)
  factory SellerModel.fromMap(Map<String, dynamic> map, String documentId) {
    return SellerModel(
      sellerId: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'],
      rating: (map['rating'] != null) ? map['rating'].toDouble() : 0.0,
      totalReviews: map['totalReviews'] ?? 0,
      createdAt: map['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'].millisecondsSinceEpoch)
          : null,
      updatedAt: map['updatedAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'].millisecondsSinceEpoch)
          : null,
    );
  }

  // Method untuk mengkonversi SellerModel ke Map (untuk Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'rating': rating,
      'totalReviews': totalReviews,
      'createdAt': createdAt,
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }

  // Method untuk membuat copy dengan perubahan
  SellerModel copyWith({
    String? sellerId,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    double? rating,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SellerModel(
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'SellerModel(sellerId: $sellerId, name: $name, email: $email, phone: $phone, rating: $rating, totalReviews: $totalReviews)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SellerModel && other.sellerId == sellerId;
  }

  @override
  int get hashCode => sellerId.hashCode;
}