/// Redemption request data model
class RedemptionRequest {
  final String email;
  final String addressLine1;
  final String? addressLine2;
  final String phoneNumber;
  final String selectedSize;
  final String itemId;
  final int cost;

  const RedemptionRequest({
    required this.email,
    required this.addressLine1,
    this.addressLine2,
    required this.phoneNumber,
    required this.selectedSize,
    required this.itemId,
    required this.cost,
  });

  RedemptionRequest copyWith({
    String? email,
    String? addressLine1,
    String? addressLine2,
    String? phoneNumber,
    String? selectedSize,
    String? itemId,
    int? cost,
  }) {
    return RedemptionRequest(
      email: email ?? this.email,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedSize: selectedSize ?? this.selectedSize,
      itemId: itemId ?? this.itemId,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'phoneNumber': phoneNumber,
      'selectedSize': selectedSize,
      'itemId': itemId,
      'cost': cost,
    };
  }

  factory RedemptionRequest.fromJson(Map<String, dynamic> json) {
    return RedemptionRequest(
      email: json['email'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      selectedSize: json['selectedSize'] as String,
      itemId: json['itemId'] as String,
      cost: json['cost'] as int,
    );
  }
}

/// Redemption state for UI management
class RedemptionState {
  final bool isLoading;
  final bool isSubmitted;
  final String? error;
  final RedemptionRequest? currentRequest;

  const RedemptionState({
    this.isLoading = false,
    this.isSubmitted = false,
    this.error,
    this.currentRequest,
  });

  RedemptionState copyWith({
    bool? isLoading,
    bool? isSubmitted,
    String? error,
    RedemptionRequest? currentRequest,
  }) {
    return RedemptionState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      error: error ?? this.error,
      currentRequest: currentRequest ?? this.currentRequest,
    );
  }
}

/// Available redemption items
class RedemptionItem {
  final String id;
  final String name;
  final String description;
  final int cost;
  final String imageUrl;
  final List<String> availableSizes;
  final bool isAvailable;

  const RedemptionItem({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.imageUrl,
    required this.availableSizes,
    this.isAvailable = true,
  });

  RedemptionItem copyWith({
    String? id,
    String? name,
    String? description,
    int? cost,
    String? imageUrl,
    List<String>? availableSizes,
    bool? isAvailable,
  }) {
    return RedemptionItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      imageUrl: imageUrl ?? this.imageUrl,
      availableSizes: availableSizes ?? this.availableSizes,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cost': cost,
      'imageUrl': imageUrl,
      'availableSizes': availableSizes,
      'isAvailable': isAvailable,
    };
  }

  factory RedemptionItem.fromJson(Map<String, dynamic> json) {
    return RedemptionItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      cost: json['cost'] as int,
      imageUrl: json['imageUrl'] as String,
      availableSizes: List<String>.from(json['availableSizes'] as List),
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }
}