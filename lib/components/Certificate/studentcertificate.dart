import 'package:flutter/material.dart';

class StudentCertificateScreen extends StatefulWidget {
  const StudentCertificateScreen({Key? key}) : super(key: key);

  @override
  _StudentCertificateScreenState createState() =>
      _StudentCertificateScreenState();
}

class _StudentCertificateScreenState extends State<StudentCertificateScreen> {
  int _currentIndex = 1; // Show Add Certificate by default
  final List<Map<String, dynamic>> certificates = [
    {
      'name': 'Sample Transfer Certificate',
      'backgroundImage': 'Uploaded Image',
      'createdDate': '2024-01-15',
    },
    {
      'name': 'School Leaving Certificate',
      'backgroundImage': 'No Image',
      'createdDate': '2024-01-10',
    },
    {
      'name': 'Character Certificate',
      'backgroundImage': 'Uploaded Image',
      'createdDate': '2024-01-05',
    },
  ];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _certificateNameController =
      TextEditingController();
  final TextEditingController _headerLeftController = TextEditingController();
  final TextEditingController _headerCenterController = TextEditingController();
  final TextEditingController _headerRightController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  final TextEditingController _footerLeftController = TextEditingController();
  final TextEditingController _footerCenterController = TextEditingController();
  final TextEditingController _footerRightController = TextEditingController();
  
  bool _hasBackgroundImage = false;
  bool _studentPhotoEnabled = true;
  
  double _headerHeight = 80.0;
  double _footerHeight = 60.0;
  double _bodyHeight = 300.0;
  double _bodyWidth = 700.0;
  double _photoHeight = 100.0;

  @override
  void initState() {
    super.initState();
    _certificateNameController.text = 'Transfer Certificate';
    _headerCenterController.text = 'SCHOOL NAME';
    _footerCenterController.text = 'Principal Signature';
    _bodyTextController.text = 'This is to certify that [name] has successfully completed...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Certificate Management'),
        backgroundColor: const Color(0xFFB71C1C),
        centerTitle: true,
        elevation: 3,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildCertificateList(),
          _buildAddCertificateForm(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCertificateList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row - FIXED OVERFLOW
          Row(
            children: [
              Expanded(
                child: Text(
                  'Student Certificate List',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFB71C1C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search certificates...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Data Table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 800 
                      ? MediaQuery.of(context).size.width 
                      : 800,
                  child: DataTable(
                    columnSpacing: 20,
                    horizontalMargin: 16,
                    headingRowColor: MaterialStateProperty.all(Colors.blue[50]),
                    headingRowHeight: 50,
                    dataRowHeight: 60,
                    columns: const [
                      DataColumn(
                        label: SizedBox(
                          width: 200,
                          child: Text(
                            'Certificate Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 150,
                          child: Text(
                            'Background Image',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 120,
                          child: Text(
                            'Created Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 140,
                          child: Text(
                            'Actions',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                    rows: certificates.map((certificate) {
                      return DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 200,
                              child: Text(
                                certificate['name'],
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 150,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: certificate['backgroundImage'] == 'Uploaded Image'
                                      ? Colors.green[50]
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: certificate['backgroundImage'] == 'Uploaded Image'
                                        ? const Color(0xFFB71C1C)
                                        : Colors.grey,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 14,
                                      color: certificate['backgroundImage'] == 'Uploaded Image'
                                          ? const Color(0xFFB71C1C)
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        certificate['backgroundImage'],
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: certificate['backgroundImage'] == 'Uploaded Image'
                                              ? const Color(0xFFB71C1C)
                                              : Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 120,
                              child: Text(
                                certificate['createdDate'],
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 140,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: const Color(0xFFB71C1C), size: 16),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 30,
                                        minHeight: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red, size: 16),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 30,
                                        minHeight: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    IconButton(
                                      icon: const Icon(Icons.visibility, color: Colors.green, size: 16),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 30,
                                        minHeight: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Footer with Pagination - FIXED OVERFLOW
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Records: 1 to 3 of 3',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 18),
                      onPressed: () {},
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB71C1C),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 18),
                      onPressed: () {},
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildAddCertificateForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row - FIXED OVERFLOW
          Row(
            children: [
              Expanded(
                child: Text(
                  'Add Student Certificate',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFB71C1C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.list, size: 18),
                  label: const Text('View List'),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Main Form Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Certificate Name
                  _buildFormField(
                    label: 'Certificate Name *',
                    controller: _certificateNameController,
                    isRequired: true,
                    icon: Icons.title,
                  ),
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Certificate Design',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFFB71C1C)),
                  ),
                  const SizedBox(height: 15),
                  
                  // Header Section
                  _buildSectionCard(
                    title: 'Header Section',
                    icon: Icons.format_align_center,
                    children: [
                      _buildFormField(
                        label: 'Header Left Text',
                        controller: _headerLeftController,
                        icon: Icons.format_align_left,
                      ),
                      const SizedBox(height: 10),
                      _buildFormField(
                        label: 'Header Center Text',
                        controller: _headerCenterController,
                        icon: Icons.format_align_center,
                      ),
                      const SizedBox(height: 10),
                      _buildFormField(
                        label: 'Header Right Text',
                        controller: _headerRightController,
                        icon: Icons.format_align_right,
                      ),
                      const SizedBox(height: 12),
                      _buildSliderWithLabel(
                        label: 'Header Height',
                        value: _headerHeight,
                        min: 50,
                        max: 200,
                        unit: 'px',
                        onChanged: (value) {
                          setState(() {
                            _headerHeight = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Body Section
                  _buildSectionCard(
                    title: 'Body Section',
                    icon: Icons.text_fields,
                    children: [
                      _buildFormFieldWithLines(
                        label: 'Body Text *',
                        controller: _bodyTextController,
                        maxLines: 5,
                        isRequired: true,
                        icon: Icons.text_format,
                      ),
                      const SizedBox(height: 10),
                      
                      // Placeholder Chips
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Available Placeholders',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: _buildPlaceholderChips(),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Click any placeholder to insert into body text',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Body Dimensions
                      _buildSliderWithLabel(
                        label: 'Body Height',
                        value: _bodyHeight,
                        min: 200,
                        max: 500,
                        unit: 'px',
                        onChanged: (value) {
                          setState(() {
                            _bodyHeight = value;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildSliderWithLabel(
                        label: 'Body Width',
                        value: _bodyWidth,
                        min: 500,
                        max: 1000,
                        unit: 'px',
                        onChanged: (value) {
                          setState(() {
                            _bodyWidth = value;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Student Photo Toggle - FIXED OVERFLOW
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.photo_library, size: 20, color: const Color(0xFFB71C1C)),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Student Photo',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Switch(
                              value: _studentPhotoEnabled,
                              activeColor: const Color(0xFFB71C1C),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) {
                                setState(() {
                                  _studentPhotoEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Photo Height (conditional)
                      if (_studentPhotoEnabled) ...[
                        _buildSliderWithLabel(
                          label: 'Photo Height',
                          value: _photoHeight,
                          min: 50,
                          max: 200,
                          unit: 'px',
                          onChanged: (value) {
                            setState(() {
                              _photoHeight = value;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Background Image Section
                  _buildSectionCard(
                    title: 'Background Image',
                    icon: Icons.image,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _hasBackgroundImage = !_hasBackgroundImage;
                          });
                        },
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _hasBackgroundImage ? Colors.green : const Color(0xFFB71C1C),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: _hasBackgroundImage ? Colors.green[50] : Colors.blue[50],
                          ),
                          child: _hasBackgroundImage
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green, size: 50),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Background Image Uploaded',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Click to remove or change',
                                      style: TextStyle(color: Colors.green, fontSize: 11),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cloud_upload, size: 50, color: const Color(0xFFB71C1C)),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Drag and drop a file here or click',
                                      style: TextStyle(color: const Color(0xFFB71C1C), fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Recommended: 800x600px',
                                      style: TextStyle(color: const Color(0xFFB71C1C), fontSize: 11),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Footer Section
                  _buildSectionCard(
                    title: 'Footer Section',
                    icon: Icons.format_align_center,
                    children: [
                      _buildFormField(
                        label: 'Footer Left Text',
                        controller: _footerLeftController,
                        icon: Icons.format_align_left,
                      ),
                      const SizedBox(height: 10),
                      _buildFormField(
                        label: 'Footer Center Text',
                        controller: _footerCenterController,
                        icon: Icons.format_align_center,
                      ),
                      const SizedBox(height: 10),
                      _buildFormField(
                        label: 'Footer Right Text',
                        controller: _footerRightController,
                        icon: Icons.format_align_right,
                      ),
                      const SizedBox(height: 12),
                      _buildSliderWithLabel(
                        label: 'Footer Height',
                        value: _footerHeight,
                        min: 30,
                        max: 150,
                        unit: 'px',
                        onChanged: (value) {
                          setState(() {
                            _footerHeight = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons - FIXED OVERFLOW
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Certificate saved successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Save Certificate',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(color: const Color(0xFFB71C1C)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.list, color: const Color(0xFFB71C1C), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'View List',
                                style: TextStyle(fontSize: 15, color: const Color(0xFFB71C1C)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            _resetForm();
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, color: Colors.grey, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Reset Form',
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: Colors.blue),
              const SizedBox(width: 6),
            ],
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  children: isRequired
                      ? const [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildFormFieldWithLines({
    required String label,
    required TextEditingController controller,
    required int maxLines,
    bool isRequired = false,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: Colors.blue),
              const SizedBox(width: 6),
            ],
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  children: isRequired
                      ? const [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.blue),
                const SizedBox(width: 6),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSliderWithLabel({
    required String label,
    required double value,
    required double min,
    required double max,
    required String unit,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: (max - min).round(),
                label: '${value.round()} $unit',
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
                onChanged: onChanged,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Text(
                '${value.round()} $unit',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _currentIndex == 0 ? Colors.blue[50] : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.list_alt,
                color: _currentIndex == 0 ? Colors.blue : Colors.grey[600],
                size: 22,
              ),
            ),
            label: 'Certificate List',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _currentIndex == 1 ? Colors.blue[50] : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _currentIndex == 1 ? Icons.add_circle : Icons.add_circle_outline,
                color: _currentIndex == 1 ? Colors.blue : Colors.grey[600],
                size: 22,
              ),
            ),
            label: 'Add Certificate',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPlaceholderChips() {
    final placeholders = [
      '[name]',
      '[dob]',
      '[present_address]',
      '[guardian]',
      '[created_at]',
      '[admission_no]',
      '[roll_no]',
      '[class]',
      '[section]',
      '[gender]',
      '[admission_date]',
      '[category]',
      '[cast]',
      '[father_name]',
      '[mother_name]',
      '[religion]',
      '[email]',
      '[phone]',
    ];

    return placeholders.map((placeholder) {
      return GestureDetector(
        onTap: () {
          final currentText = _bodyTextController.text;
          _bodyTextController.text = '$currentText$placeholder ';
        },
        child: Chip(
          label: Text(
            placeholder,
            style: const TextStyle(fontSize: 10),
          ),
          backgroundColor: Colors.blue[50],
          side: BorderSide(color: Colors.blue[100]!),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          visualDensity: VisualDensity.compact,
        ),
      );
    }).toList();
  }

  void _resetForm() {
    setState(() {
      _certificateNameController.clear();
      _headerLeftController.clear();
      _headerCenterController.clear();
      _headerRightController.clear();
      _bodyTextController.clear();
      _footerLeftController.clear();
      _footerCenterController.clear();
      _footerRightController.clear();
      _hasBackgroundImage = false;
      _studentPhotoEnabled = true;
      _headerHeight = 80.0;
      _footerHeight = 60.0;
      _bodyHeight = 300.0;
      _bodyWidth = 700.0;
      _photoHeight = 100.0;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _certificateNameController.dispose();
    _headerLeftController.dispose();
    _headerCenterController.dispose();
    _headerRightController.dispose();
    _bodyTextController.dispose();
    _footerLeftController.dispose();
    _footerCenterController.dispose();
    _footerRightController.dispose();
    super.dispose();
  }
}