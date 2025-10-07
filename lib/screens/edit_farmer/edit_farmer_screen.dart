import 'package:flutter/material.dart';
import '../../models/app_data.dart';
import '../../models/farmer_item.dart';

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
      
      AppData.updateFarmer(updatedFarmer);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated farmer: ${_nameCtrl.text}'),
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