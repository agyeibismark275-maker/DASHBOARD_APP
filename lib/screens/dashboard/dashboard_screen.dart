import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../models/app_data.dart';
import '../registered_pcs/registered_pcs_screen.dart';
import '../registered_farmers/registered_farmers_screen.dart';
import '../register_pc/register_pc_screen.dart';
import '../register_farmer/register_farmer_screen.dart';
import '../reallocate/reallocate_screen.dart';
import '../sanction/sanction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      return;
    }
    if (!mounted) return;
    setState(() => _connectionStatus = result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() => _connectionStatus = result);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xFF142210),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _connectionStatus != ConnectivityResult.none
                  ? const Color(0xFF46ec13).withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  _connectionStatus != ConnectivityResult.none
                      ? Icons.wifi
                      : Icons.wifi_off,
                  size: 16,
                  color: _connectionStatus != ConnectivityResult.none
                      ? const Color(0xFF46ec13)
                      : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  _connectionStatus != ConnectivityResult.none ? 'Online' : 'Offline',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _connectionStatus != ConnectivityResult.none
                        ? const Color(0xFF142210)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF142210)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings pressed')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFF142210).withOpacity(0.2),
                  ),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search PC or Farmer by name, ID...',
                    hintStyle: TextStyle(
                      color: const Color(0xFF142210).withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color(0xFF142210).withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Searching for: $value')),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Registered PCs',
                      AppData.registeredPCCount.toString(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      'Registered Farmers',
                      AppData.registeredFarmerCount.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF142210),
                ),
              ),
              const SizedBox(height: 16),

              _buildActionButton(
                'Register PC',
                Icons.add_box_outlined,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterPCScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildActionButton(
                'View Registered PCs',
                Icons.list_alt,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisteredPCsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildActionButton(
                'View Registered Farmers',
                Icons.people_outline,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisteredFarmersScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildActionButton(
                'Register Farmer',
                Icons.person_add_outlined,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterFarmerScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildActionButton(
                'Reallocate Farmers',
                Icons.swap_horiz,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReallocateScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildActionButton(
                'Sanction Farmers',
                Icons.gavel_outlined,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SanctionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF46ec13).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF142210).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF142210),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF46ec13),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}