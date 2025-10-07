import 'package:flutter/material.dart';
import '../../models/app_data.dart';
import '../../models/pc_item.dart';

class RegisteredPCsScreen extends StatefulWidget {
  const RegisteredPCsScreen({super.key});

  @override
  State<RegisteredPCsScreen> createState() => _RegisteredPCsScreenState();
}

class _RegisteredPCsScreenState extends State<RegisteredPCsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<PCItem> _filteredPCs = [];

  @override
  void initState() {
    super.initState();
    _filteredPCs = AppData.allPCs;
    _searchCtrl.addListener(_filterPCs);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _filterPCs() {
    final query = _searchCtrl.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredPCs = AppData.allPCs;
      } else {
        _filteredPCs = AppData.allPCs.where((pc) {
          return pc.name.toLowerCase().contains(query) ||
              pc.district.toLowerCase().contains(query) ||
              pc.community.toLowerCase().contains(query);
        }).toList();
      }
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
          'Registered PCs',
          style: TextStyle(
            color: Color(0xFF142210),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          SizedBox(width: 56),
        ],
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
                  hintText: 'Search PCs',
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
              itemCount: _filteredPCs.length,
              itemBuilder: (context, index) {
                final pc = _filteredPCs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Viewing ${pc.name}')),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF46ec13).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF46ec13).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.corporate_fare,
                                color: Color(0xFF142210),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pc.name,
                                    style: const TextStyle(
                                      color: Color(0xFF142210),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'District: ${pc.district}, Community: ${pc.community}',
                                    style: TextStyle(
                                      color: const Color(0xFF142210).withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
}