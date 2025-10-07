import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const MyDashboardApp());
}

class MyDashboardApp extends StatelessWidget {
  const MyDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF46ec13),
        scaffoldBackgroundColor: const Color(0xFFF6F8F6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF46ec13),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RegisterPCScreen(),
    const RegisterFarmerScreen(),
    const ReallocateScreen(),
    const SanctionScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
        physics: const BouncingScrollPhysics(), // Enable swipe navigation
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8F6).withOpacity(0.8),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF46ec13).withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF46ec13),
          unselectedItemColor: const Color(0xFF142210).withOpacity(0.6),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Register PC',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_outlined),
              label: 'Register Farmer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Reallocate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gavel_outlined),
              label: 'Sanction',
            ),
          ],
        ),
      ),
    );
  }
}

// Data storage class for managing counts
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

// ========================================
// DASHBOARD SCREEN
// ========================================
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
          // Online/Offline indicator
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
              // Search Bar
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

              // Metrics Grid - Now with live counts
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

              // Quick Actions Section
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
                      builder: (_) => const RegisterPCScreen(),
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
                      builder: (_) => const RegisteredPCsScreen(),
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
                      builder: (_) => const RegisteredFarmersScreen(),
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
                      builder: (_) => const RegisterFarmerScreen(),
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
                      builder: (_) => const ReallocateScreen(),
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
                      builder: (_) => const SanctionScreen(),
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

// ========================================
// REGISTERED PCs LIST SCREEN
// ========================================
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
          SizedBox(width: 56), // Balance the back button
        ],
      ),
      body: Column(
        children: [
          // Search Bar
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

          // PC List
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
                            // Icon Container
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
                            // PC Info
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

// ========================================
// REGISTERED FARMERS LIST SCREEN
// ========================================
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
      // Refresh the list when returning from edit screen
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
          // Search Bar
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

          // Farmers List
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

class PCItem {
  final String name;
  final String district;
  final String community;

  PCItem({
    required this.name,
    required this.district,
    required this.community,
  });
}

// ========================================
// REGISTER PC SCREEN (Updated with count increment)
// ========================================
class RegisterPCScreen extends StatefulWidget {
  const RegisterPCScreen({super.key});

  @override
  State<RegisterPCScreen> createState() => _RegisterPCScreenState();
}

class _RegisterPCScreenState extends State<RegisterPCScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pcNameCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _contactPersonCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  String _selectedDistrict = 'Select District';
  String _selectedCommunity = 'Select Community/Society';

  @override
  void dispose() {
    _pcNameCtrl.dispose();
    _addressCtrl.dispose();
    _contactPersonCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _registerPC() {
    if (_formKey.currentState!.validate()) {
      // Create new PC item
      final newPC = PCItem(
        name: _pcNameCtrl.text,
        district: _selectedDistrict,
        community: _selectedCommunity,
      );
      
      // Add to data storage
      AppData.addPC(newPC);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PC Registered: ${_pcNameCtrl.text}'),
          backgroundColor: const Color(0xFF53d22d),
        ),
      );
      
      // Navigate back to dashboard
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF152012)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Register PC',
          style: TextStyle(
            color: Color(0xFF152012),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: const Color(0xFF53d22d).withOpacity(0.2),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'PC Name',
                      controller: _pcNameCtrl,
                      placeholder: 'Enter PC Name',
                      validator: (v) => v?.isEmpty ?? true ? 'PC Name is required' : null,
                    ),
                    const SizedBox(height: 24),

                    _buildTextField(
                      label: 'Address',
                      controller: _addressCtrl,
                      placeholder: 'Enter Address',
                      validator: (v) => v?.isEmpty ?? true ? 'Address is required' : null,
                    ),
                    const SizedBox(height: 24),

                    _buildTextField(
                      label: 'Contact Person',
                      controller: _contactPersonCtrl,
                      placeholder: 'Enter Contact Person',
                      validator: (v) => v?.isEmpty ?? true ? 'Contact Person is required' : null,
                    ),
                    const SizedBox(height: 24),

                    _buildTextField(
                      label: 'Phone Number',
                      controller: _phoneCtrl,
                      placeholder: 'Enter Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (v) => v?.isEmpty ?? true ? 'Phone Number is required' : null,
                    ),
                    const SizedBox(height: 24),

                    _buildDropdown(
                      label: 'District',
                      value: _selectedDistrict,
                      items: ['Select District', 'District 1', 'District 2'],
                      onChanged: (v) => setState(() => _selectedDistrict = v!),
                    ),
                    const SizedBox(height: 24),

                    _buildDropdown(
                      label: 'Communities/Societies',
                      value: _selectedCommunity,
                      items: ['Select Community/Society', 'Community A', 'Community B'],
                      onChanged: (v) => setState(() => _selectedCommunity = v!),
                    ),
                  ],
                ),
              ),
            ),
            // Sticky footer with register button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8F6),
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFF53d22d).withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _registerPC,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF53d22d),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Register PC',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF152012),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFF6b7280),
            ),
            filled: true,
            fillColor: const Color(0xFFF6F8F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(0xFF53d22d).withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(0xFF53d22d).withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF53d22d),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF152012),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF53d22d).withOpacity(0.3),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF53d22d),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF333333)),
          ),
        ),
      ],
    );
  }
}

// ========================================
// REGISTER FARMER SCREEN (Updated with count increment)
// ========================================
class RegisterFarmerScreen extends StatefulWidget {
  const RegisterFarmerScreen({super.key});

  @override
  State<RegisterFarmerScreen> createState() => _RegisterFarmerScreenState();
}

class _RegisterFarmerScreenState extends State<RegisterFarmerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _societyCtrl = TextEditingController();
  final TextEditingController _districtCtrl = TextEditingController();
  final TextEditingController _birthYearCtrl = TextEditingController();
  final TextEditingController _ghanaCardCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _cocobodIdCtrl = TextEditingController();
  final TextEditingController _numFarmsCtrl = TextEditingController();
  final TextEditingController _hectaresCtrl = TextEditingController();

  String _selectedGender = 'Select';
  String _selectedPC = 'Select PC';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _societyCtrl.dispose();
    _districtCtrl.dispose();
    _birthYearCtrl.dispose();
    _ghanaCardCtrl.dispose();
    _phoneCtrl.dispose();
    _cocobodIdCtrl.dispose();
    _numFarmsCtrl.dispose();
    _hectaresCtrl.dispose();
    super.dispose();
  }

  void _registerFarmer() {
    if (_formKey.currentState!.validate()) {
      // Create new farmer item
      final newFarmer = FarmerItem(
        name: _nameCtrl.text,
        id: '${DateTime.now().millisecondsSinceEpoch}', // Generate unique ID
        imageUrl: 'https://via.placeholder.com/150',
        birthYear: _birthYearCtrl.text,
        ghanaCard: _ghanaCardCtrl.text,
        phone: _phoneCtrl.text,
        gender: _selectedGender,
        farmSize: _hectaresCtrl.text,
        crop: 'Cocoa', // Default value
        producerCooperative: _selectedPC,
      );
      
      // Add to data storage
      AppData.addFarmer(newFarmer);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Farmer Registered: ${_nameCtrl.text}'),
          backgroundColor: const Color(0xFF46ec13),
        ),
      );
      
      // Navigate back to dashboard
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF152012)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Register Farmer',
          style: TextStyle(
            color: Color(0xFF152012),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Farmer Name',
                      controller: _nameCtrl,
                      placeholder: "Enter farmer's full name",
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Society',
                      controller: _societyCtrl,
                      placeholder: 'Enter society name',
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'District',
                      controller: _districtCtrl,
                      placeholder: 'Enter district',
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: 'Birth Year',
                            controller: _birthYearCtrl,
                            placeholder: 'YYYY',
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v?.isEmpty ?? true) return 'Required';
                              final year = int.tryParse(v!);
                              if (year == null || year < 1900 || year > DateTime.now().year) {
                                return 'Invalid year';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdown(
                            label: 'Gender',
                            value: _selectedGender,
                            items: ['Select', 'Male', 'Female', 'Other'],
                            onChanged: (v) => setState(() => _selectedGender = v!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Ghana Card Number',
                      controller: _ghanaCardCtrl,
                      placeholder: 'Enter Ghana Card number',
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Phone Number',
                      controller: _phoneCtrl,
                      placeholder: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Cocobod ID',
                      controller: _cocobodIdCtrl,
                      placeholder: 'Enter Cocobod ID',
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: 'Number of Farms',
                            controller: _numFarmsCtrl,
                            placeholder: 'e.g. 3',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: 'Hectares',
                            controller: _hectaresCtrl,
                            placeholder: 'e.g. 2.5',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildDropdown(
                      label: 'Producer Cooperative (PC)',
                      value: _selectedPC,
                      items: ['Select PC', 'PC One', 'PC Two', 'PC Three'],
                      onChanged: (v) => setState(() => _selectedPC = v!),
                    ),
                  ],
                ),
              ),
            ),
            // Sticky footer with register button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8F6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _registerFarmer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF53d22d),
                    foregroundColor: const Color(0xFF152012),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Register Farmer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF152012),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: const Color(0xFF6b7280),
            ),
            filled: true,
            fillColor: const Color(0xFFe9ede8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF53d22d),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF152012),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFe9ede8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF53d22d),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6b7280)),
          ),
        ),
      ],
    );
  }
}

// ========================================
// EDIT FARMER SCREEN (Updated with data persistence)
// ========================================
class EditFarmerScreen extends StatefulWidget {
  final FarmerItem farmer;

  const EditFarmerScreen({super.key, required this.farmer});

  @override
  State<EditFarmerScreen> createState() => _EditFarmerScreenState();
}

class _EditFarmerScreenState extends State<EditFarmerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _birthYearCtrl = TextEditingController();
  final TextEditingController _ghanaCardCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _farmSizeCtrl = TextEditingController();
  final TextEditingController _cropCtrl = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedPC = 'Asunafo North PC';

  @override
  void initState() {
    super.initState();
    // Pre-fill form with farmer data
    _nameCtrl.text = widget.farmer.name;
    _birthYearCtrl.text = widget.farmer.birthYear ?? '1985';
    _ghanaCardCtrl.text = widget.farmer.ghanaCard ?? 'GHA-123456789-0';
    _phoneCtrl.text = widget.farmer.phone ?? '024 123 4567';
    _farmSizeCtrl.text = widget.farmer.farmSize ?? '12.5';
    _cropCtrl.text = widget.farmer.crop ?? 'Cocoa';
    _selectedGender = widget.farmer.gender ?? 'Male';
    _selectedPC = widget.farmer.producerCooperative ?? 'Asunafo North PC';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _birthYearCtrl.dispose();
    _ghanaCardCtrl.dispose();
    _phoneCtrl.dispose();
    _farmSizeCtrl.dispose();
    _cropCtrl.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Create updated farmer
      final updatedFarmer = FarmerItem(
        name: _nameCtrl.text,
        id: widget.farmer.id,
        status: widget.farmer.status,
        imageUrl: widget.farmer.imageUrl,
        birthYear: _birthYearCtrl.text,
        ghanaCard: _ghanaCardCtrl.text,
        phone: _phoneCtrl.text,
        gender: _selectedGender,
        farmSize: _farmSizeCtrl.text,
        crop: _cropCtrl.text,
        producerCooperative: _selectedPC,
        isSelected: widget.farmer.isSelected,
        sanctionHistory: widget.farmer.sanctionHistory,
      );
      
      // Update in data storage
      AppData.updateFarmer(updatedFarmer);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated farmer: ${_nameCtrl.text}'),
          backgroundColor: const Color(0xFF46ec13),
        ),
      );
      Navigator.pop(context); // Go back to previous screen
    }
  }

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
          'Edit Farmer',
          style: TextStyle(
            color: Color(0xFF142210),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Name',
                      controller: _nameCtrl,
                      placeholder: 'Enter farmer name',
                      validator: (v) => v?.isEmpty ?? true ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Birth Year',
                      controller: _birthYearCtrl,
                      placeholder: 'YYYY',
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v?.isEmpty ?? true) return 'Birth year is required';
                        final year = int.tryParse(v!);
                        if (year == null || year < 1900 || year > DateTime.now().year) {
                          return 'Invalid year';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Ghana Card',
                      controller: _ghanaCardCtrl,
                      placeholder: 'Enter Ghana Card number',
                      validator: (v) => v?.isEmpty ?? true ? 'Ghana Card is required' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Phone',
                      controller: _phoneCtrl,
                      placeholder: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    _buildDropdown(
                      label: 'Gender',
                      value: _selectedGender,
                      items: const ['Male', 'Female', 'Other'],
                      onChanged: (v) => setState(() => _selectedGender = v!),
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Farm Size (acres)',
                      controller: _farmSizeCtrl,
                      placeholder: 'Enter farm size',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Crop',
                      controller: _cropCtrl,
                      placeholder: 'Enter main crop',
                    ),
                    const SizedBox(height: 16),

                    _buildDropdown(
                      label: 'Producer Cooperative',
                      value: _selectedPC,
                      items: const ['Asunafo North PC', 'Sefwi Wiawso PC', 'Juaboso-Bia PC'],
                      onChanged: (v) => setState(() => _selectedPC = v!),
                    ),
                  ],
                ),
              ),
            ),

            // Save Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8F6),
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFF46ec13).withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF46ec13),
                    foregroundColor: const Color(0xFF142210),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF142210),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFF6b7280),
            ),
            filled: true,
            fillColor: const Color(0xFFF6F8F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFF46ec13).withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFF46ec13).withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF46ec13),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF142210),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8F6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF46ec13).withOpacity(0.3),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF46ec13),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF142210)),
          ),
        ),
      ],
    );
  }
}

// [Rest of your existing code for ReallocateScreen, SanctionScreen, FarmerItem, SanctionHistory, ReallocateFarmer remains the same...]
// ========================================
// REALLOCATE SCREEN
// ========================================
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
          // Search and Filter
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

          // Farmers List
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

// ========================================
// SANCTION SCREEN
// ========================================
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
          // Search Bar
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

          // Farmers List
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

// ========================================
// DATA MODELS
// ========================================
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
class FarmerItem {
  final String name;
  final String id;
  final String? status;
  final String imageUrl;
  bool isSelected;
  final List<SanctionHistory> sanctionHistory;
  
  // ADD THESE NEW PROPERTIES for editing
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
    
    // ADD THESE to the constructor with default values
    this.birthYear,
    this.ghanaCard,
    this.phone,
    this.gender,
    this.farmSize,
    this.crop,
    this.producerCooperative,
  });
}

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
