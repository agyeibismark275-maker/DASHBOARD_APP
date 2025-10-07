import 'package:flutter/material.dart';
import '../../models/farmer_item.dart';

class ReallocateScreen extends StatefulWidget {
  const ReallocateScreen({super.key});

  @override
  State<ReallocateScreen> createState() => _ReallocateScreenState();
}

class _ReallocateScreenState extends State<ReallocateScreen> {
  final List<ReallocateFarmer> _farmers = [
    ReallocateFarmer(
      name: 'Kwame Mensah',
      id: '12345',
      currentPC: 'Asunafo North PC',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD2zVg2AnDgFZjgXc7j6HNIhRhApUa-uwRKNq9CKSSo_u5F85Dfte4AnV1oONoo0XhNiOiusZQjk8SkQop30_9btkMh34VUrDtWG1WC3-vEvV4E3XxZNIvzBcmlukHUBNylsHVNq1OVFOGeSTd4hQz1WrN27AOlFB_qJ2fsiAoP4EFIeEuCJOR-SUdQIUa-VeC7cyEis_cQxDoN2FoIgsP9MRTUVqXZ55nztGdmQzgNo1fznaS1Bl4PcjOWiFzhuw5oRW0-Ao_KaZLD',
    ),
    ReallocateFarmer(
      name: 'Aisha Ibrahim',
      id: '67890',
      currentPC: 'Sefwi Wiawso PC',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBvjFbZA99H4HUYCJB26nBX-iFUTSx9x_EGPKxA7iNSbPbEL3jxgiWLvQ7br8R3Wz9sfB7wUTKVDB03WpUrV8Wty9A4Toz4u1Afulr_bKOzjwm-hF3espwaMKH10-nDvol49iTyXwlDdv-mHCC4NfVMQKEiJy2VDbKpFn4kmRTm6Nx19Z5l5Wh7LrHShrO3RlEYs_AxVA5nDRuTzCZ1_mJOThrY-x8btiwNyZOwH6e-6LwZQiCVkUJc21BC1m92rrHiAXxvgJrQv8-P',
    ),
  ];

  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedNewPC = 'Select PC';

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
          'Reallocate Farmers',
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF46ec13).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search farmers...',
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
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF46ec13).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedNewPC,
                    items: ['Select PC', 'New PC 1', 'New PC 2', 'New PC 3']
                        .map((pc) => DropdownMenuItem(
                              value: pc,
                              child: Text(pc),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedNewPC = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
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
                      subtitle: Text(
                        'ID: ${farmer.id} • Current: ${farmer.currentPC}',
                        style: TextStyle(
                          color: const Color(0xFF142210).withOpacity(0.7),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: _selectedNewPC != 'Select PC'
                            ? () {
                                _reallocateFarmer(farmer, _selectedNewPC);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF46ec13),
                          foregroundColor: const Color(0xFF142210),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Reallocate'),
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

  void _reallocateFarmer(ReallocateFarmer farmer, String newPC) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reallocated ${farmer.name} to $newPC'),
        backgroundColor: const Color(0xFF46ec13),
      ),
    );
  }
}