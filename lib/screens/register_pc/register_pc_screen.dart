import 'package:flutter/material.dart';
import '../../models/app_data.dart';
import '../../models/pc_item.dart';

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
      final newPC = PCItem(
        name: _pcNameCtrl.text,
        district: _selectedDistrict,
        community: _selectedCommunity,
      );
      
      AppData.addPC(newPC);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PC Registered: ${_pcNameCtrl.text}'),
          backgroundColor: const Color(0xFF53d22d),
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
                      items: const ['Select District', 'District 1', 'District 2'],
                      onChanged: (v) => setState(() => _selectedDistrict = v!),
                    ),
                    const SizedBox(height: 24),

                    _buildDropdown(
                      label: 'Communities/Societies',
                      value: _selectedCommunity,
                      items: const ['Select Community/Society', 'Community A', 'Community B'],
                      onChanged: (v) => setState(() => _selectedCommunity = v!),
                    ),
                  ],
                ),
              ),
            ),
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