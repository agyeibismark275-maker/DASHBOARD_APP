import 'package:flutter/material.dart';
import '../../models/farmer_item.dart';

class SanctionScreen extends StatefulWidget {
  const SanctionScreen({super.key});

  @override
  State<SanctionScreen> createState() => _SanctionScreenState();
}

class _SanctionScreenState extends State<SanctionScreen> {
  final List<FarmerItem> _farmers = [
    FarmerItem(
      name: 'Kwame Mensah',
      id: '12345',
      status: 'Active',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD2zVg2AnDgFZjgXc7j6HNIhRhApUa-uwRKNq9CKSSo_u5F85Dfte4AnV1oONoo0XhNiOiusZQjk8SkQop30_9btkMh34VUrDtWG1WC3-vEvV4E3XxZNIvzBcmlukHUBNylsHVNq1OVFOGeSTd4hQz1WrN27AOlFB_qJ2fsiAoP4EFIeEuCJOR-SUdQIUa-VeC7cyEis_cQxDoN2FoIgsP9MRTUVqXZ55nztGdmQzgNo1fznaS1Bl4PcjOWiFzhuw5oRW0-Ao_KaZLD',
      sanctionHistory: [
        SanctionHistory(
          reason: 'Late payment',
          date: '2023-01-15',
          status: 'Resolved',
        ),
      ],
    ),
    FarmerItem(
      name: 'Aisha Ibrahim',
      id: '67890',
      status: 'Active',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBvjFbZA99H4HUYCJB26nBX-iFUTSx9x_EGPKxA7iNSbPbEL3jxgiWLvQ7br8R3Wz9sfB7wUTKVDB03WpUrV8Wty9A4Toz4u1Afulr_bKOzjwm-hF3espwaMKH10-nDvol49iTyXwlDdv-mHCC4NfVMQKEiJy2VDbKpFn4kmRTm6Nx19Z5l5Wh7LrHShrO3RlEYs_AxVA5nDRuTzCZ1_mJOThrY-x8btiwNyZOwH6e-6LwZQiCVkUJc21BC1m92rrHiAXxvgJrQv8-P',
      sanctionHistory: [],
    ),
  ];

  final TextEditingController _searchCtrl = TextEditingController();
  final TextEditingController _sanctionReasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF142210)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Sanction Farmers',
          style: TextStyle(
            color: Color(0xFF142210),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF46ec13).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search farmers to sanction...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF142210).withOpacity(0.7),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF142210).withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _farmers.length,
              itemBuilder: (context, index) {
                final farmer = _farmers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF46ec13).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          farmer.imageUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 48,
                            height: 48,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ),
                      title: Text(
                        farmer.name,
                        style: const TextStyle(
                          color: Color(0xFF142210),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: ${farmer.id} • ${farmer.status}',
                            style: TextStyle(
                              color: const Color(0xFF142210).withOpacity(0.7),
                            ),
                          ),
                          if (farmer.sanctionHistory.isNotEmpty)
                            Text(
                              '${farmer.sanctionHistory.length} sanction(s)',
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.gavel, color: Color(0xFF142210)),
                        onPressed: () => _showSanctionDialog(farmer),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSanctionDialog(FarmerItem farmer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sanction ${farmer.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Reason for sanction:'),
            const SizedBox(height: 8),
            TextField(
              controller: _sanctionReasonCtrl,
              decoration: const InputDecoration(
                hintText: 'Enter sanction reason...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_sanctionReasonCtrl.text.isNotEmpty) {
                _applySanction(farmer, _sanctionReasonCtrl.text);
                Navigator.pop(context);
                _sanctionReasonCtrl.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF46ec13),
              foregroundColor: const Color(0xFF142210),
            ),
            child: const Text('Apply Sanction'),
          ),
        ],
      ),
    );
  }

  void _applySanction(FarmerItem farmer, String reason) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sanction applied to ${farmer.name}: $reason'),
        backgroundColor: const Color(0xFF46ec13),
      ),
    );
  }
}