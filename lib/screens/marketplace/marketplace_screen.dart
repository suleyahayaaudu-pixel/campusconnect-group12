import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> items = [
    {
      'name': 'HP Laptop',
      'price': '₦180,000',
      'category': 'Electronics',
      'seller': 'Aisha',
      'status': 'Available',
      'icon': Icons.laptop,
    },
    {
      'name': 'Software Engineering Textbook',
      'price': '₦8,000',
      'category': 'Books',
      'seller': 'Musa',
      'status': 'Available',
      'icon': Icons.menu_book,
    },
    {
      'name': 'Scientific Calculator',
      'price': '₦12,000',
      'category': 'Accessories',
      'seller': 'Fatima',
      'status': 'Reserved',
      'icon': Icons.calculate,
    },
    {
      'name': 'Android Phone',
      'price': '₦95,000',
      'category': 'Electronics',
      'seller': 'Ibrahim',
      'status': 'Available',
      'icon': Icons.phone_android,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Electronics', 'Books', 'Accessories'];

    final filteredItems = selectedCategory == 'All'
        ? items
        : items.where((item) => item['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Marketplace'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: AppConfig.secondaryColor.withValues(alpha: 0.15),
            child: const Text(
              'Peer-to-peer selling with escrow simulation and QR meetup verification',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (_) {
                      setState(() => selectedCategory = category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          AppConfig.primaryColor.withValues(alpha: 0.15),
                      child: Icon(item['icon'], color: AppConfig.primaryColor),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Seller: ${item['seller']}\nCategory: ${item['category']}\nEscrow: Simulated',
                    ),
                    isThreeLine: true,
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['price'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item['status'],
                          style: TextStyle(
                            color: item['status'] == 'Available'
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'QR meetup verification generated for ${item['name']}',
                          ),
                        ),
                      );
                    },
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
