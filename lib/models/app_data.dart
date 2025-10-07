import 'pc_item.dart';
import 'farmer_item.dart';

class AppData {
  static int registeredPCCount = 125;
  static int registeredFarmerCount = 5320;
  static final List<PCItem> _allPCs = [
    PCItem(name: 'Green Valley PC', district: 'Central', community: 'Green Valley'),
    PCItem(name: 'Hillside PC', district: 'North', community: 'Hillside'),
    PCItem(name: 'Riverbend PC', district: 'South', community: 'Riverbend'),
    PCItem(name: 'Lakeside PC', district: 'East', community: 'Lakeside'),
    PCItem(name: 'Mountain View PC', district: 'West', community: 'Mountain View'),
  ];
  static final List<FarmerItem> _allFarmers = [
    FarmerItem(
      name: 'Kwame Mensah',
      id: '12345',
      status: 'Active',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD2zVg2AnDgFZjgXc7j6HNIhRhApUa-uwRKNq9CKSSo_u5F85Dfte4AnV1oONoo0XhNiOiusZQjk8SkQop30_9btkMh34VUrDtWG1WC3-vEvV4E3XxZNIvzBcmlukHUBNylsHVNq1OVFOGeSTd4hQz1WrN27AOlFB_qJ2fsiAoP4EFIeEuCJOR-SUdQIUa-VeC7cyEis_cQxDoN2FoIgsP9MRTUVqXZ55nztGdmQzgNo1fznaS1Bl4PcjOWiFzhuw5oRW0-Ao_KaZLD',
      birthYear: '1985',
      ghanaCard: 'GHA-123456789-0',
      phone: '024 123 4567',
      gender: 'Male',
      farmSize: '12.5',
      crop: 'Cocoa',
      producerCooperative: 'Asunafo North PC',
    ),
    FarmerItem(
      name: 'Aisha Ibrahim',
      id: '67890',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBvjFbZA99H4HUYCJB26nBX-iFUTSx9x_EGPKxA7iNSbPbEL3jxgiWLvQ7br8R3Wz9sfB7wUTKVDB03WpUrV8Wty9A4Toz4u1Afulr_bKOzjwm-hF3espwaMKH10-nDvol49iTyXwlDdv-mHCC4NfVMQKEiJy2VDbKpFn4kmRTm6Nx19Z5l5Wh7LrHShrO3RlEYs_AxVA5nDRuTzCZ1_mJOThrY-x8btiwNyZOwH6e-6LwZQiCVkUJc21BC1m92rrHiAXxvgJrQv8-P',
      birthYear: '1990',
      ghanaCard: 'GHA-987654321-0',
      phone: '024 765 4321',
      gender: 'Female',
      farmSize: '8.2',
      crop: 'Coffee',
      producerCooperative: 'Sefwi Wiawso PC',
    ),
  ];

  static List<PCItem> get allPCs => List.from(_allPCs);
  static List<FarmerItem> get allFarmers => List.from(_allFarmers);

  static void addPC(PCItem pc) {
    _allPCs.add(pc);
    registeredPCCount++;
  }

  static void addFarmer(FarmerItem farmer) {
    _allFarmers.add(farmer);
    registeredFarmerCount++;
  }

  static void updateFarmer(FarmerItem updatedFarmer) {
    final index = _allFarmers.indexWhere((f) => f.id == updatedFarmer.id);
    if (index != -1) {
      _allFarmers[index] = updatedFarmer;
    }
  }
}