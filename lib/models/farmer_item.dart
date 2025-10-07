class SanctionHistory {
  final String reason;
  final String date;
  final String status;

  SanctionHistory({
    required this.reason,
    required this.date,
    required this.status,
  });
}

class FarmerItem {
  final String name;
  final String id;
  final String? status;
  final String imageUrl;
  bool isSelected;
  final List<SanctionHistory> sanctionHistory;
  
  final String? birthYear;
  final String? ghanaCard;
  final String? phone;
  final String? gender;
  final String? farmSize;
  final String? crop;
  final String? producerCooperative;

  FarmerItem({
    required this.name,
    required this.id,
    this.status,
    required this.imageUrl,
    this.isSelected = false,
    this.sanctionHistory = const [],
    this.birthYear,
    this.ghanaCard,
    this.phone,
    this.gender,
    this.farmSize,
    this.crop,
    this.producerCooperative,
  });
}

class ReallocateFarmer {
  final String name;
  final String id;
  final String currentPC;
  final String imageUrl;

  ReallocateFarmer({
    required this.name,
    required this.id,
    required this.currentPC,
    required this.imageUrl,
  });
}