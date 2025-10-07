import 'package:flutter/material.dart';
import '../../models/app_data.dart';
import '../../models/farmer_item.dart';
import '../edit_farmer/edit_farmer_screen.dart';

class RegisteredFarmersScreen extends StatefulWidget {
  const RegisteredFarmersScreen({super.key});

  @override
  State<RegisteredFarmersScreen> createState() => _RegisteredFarmersScreenState();
}

class _RegisteredFarmersScreenState extends State<RegisteredFarmersScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<FarmerItem> _filteredFarmers = [];

  @override
  void initState() {
    super.initState();
    _filteredFarmers = AppData.allFarmers;
    _searchCtrl.addListener(_filterFarmers);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _filterFarmers() {
    final query = _searchCtrl.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredFarmers = AppData.allFarmers;
      } else {
        _filteredFarmers = AppData.allFarmers.where((farmer) {
          return farmer.name.toLowerCase().contains(query) ||
              farmer.id.toLowerCase().contains(query) ||
              farmer.ghanaCard?.toLowerCase().contains(query) == true;
        }).toList();
      }
    });
  }

  void _editFarmer(FarmerItem farmer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFarmerScreen(farmer: farmer),
      ),
    ).then((_) {
      setState(() {
        _filteredFarmers = List.from(AppData.allFarmers);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF46ec13).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF142210)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Registered Farmers',
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
                  hintText: 'Search farmers by name, ID...',
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
              itemCount: _filteredFarmers.length,
              itemBuilder: (context, index) {
                final farmer = _filteredFarmers[index];
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
                        'ID: ${farmer.id} • ${farmer.producerCooperative ?? "No PC"}',
                        style: TextStyle(
                          color: const Color(0xFF142210).withOpacity(0.7),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF142210)),
                        onPressed: () => _editFarmer(farmer),
                        tooltip: 'Edit Farmer',
                      ),
                      onTap: () => _editFarmer(farmer),
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
}