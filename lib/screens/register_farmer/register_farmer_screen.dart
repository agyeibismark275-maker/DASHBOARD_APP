import 'package:flutter/material.dart';
import '../../models/app_data.dart';
import '../../models/farmer_item.dart';

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
      final newFarmer = FarmerItem(
        name: _nameCtrl.text,
        id: '${DateTime.now().millisecondsSinceEpoch}',
        imageUrl: 'https://via.placeholder.com/150',
        birthYear: _birthYearCtrl.text,
        ghanaCard: _ghanaCardCtrl.text,
        phone: _phoneCtrl.text,
        gender: _selectedGender,
        farmSize: _hectaresCtrl.text,
        crop: 'Cocoa',
        producerCooperative: _selectedPC,
      );
      
      AppData.addFarmer(newFarmer);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Farmer Registered: ${_nameCtrl.text}'),
          backgroundColor: const Color(0xFF46ec13),
        ),
      );
      
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
                            items: const ['Select', 'Male', 'Female', 'Other'],
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
                      items: const ['Select PC', 'PC One', 'PC Two', 'PC Three'],
                      onChanged: (v) => setState(() => _selectedPC = v!),
                    ),
                  ],
                ),
              ),
            ),
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
            hintStyle: const TextStyle(
              color: Color(0xFF6b7280),
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