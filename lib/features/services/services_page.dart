// services_page.dart
import 'package:flutter/material.dart';
import 'package:barber/features/appoinments/calendar_page.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({super.key, required this.barberId});
  String barberId;
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Full Set',
      'description': '60 min | Titanium Manicure',
      'price': 100.00,
      'selected': false,
    },
    {
      'title': 'Hair Cut',
      'description': '45 min | Stylish Hair Cut',
      'price': 80.00,
      'selected': false,
    },
    {
      'title': 'Beard Grooming',
      'description': '30 min | Beard Trim and Shape',
      'price': 60.00,
      'selected': false,
    },
    {
      'title': 'Relaxation Massage',
      'description': '60 min | Full Body',
      'price': 120.00,
      'selected': false,
    },
  ];

  void _toggleServiceSelection(int index) {
    setState(() {
      services[index]['selected'] = !services[index]['selected'];
    });
  }

  double _calculateTotalCost() {
    double totalCost = 0.0;
    for (var service in services) {
      if (service['selected']) {
        totalCost += service['price'];
      }
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Select a Service'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _serviceCard(
              context,
              index,
              services[index]['title']!,
              services[index]['description']!,
              services[index]['price']!,
              services[index]['selected']!,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${_calculateTotalCost().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: _calculateTotalCost() > 0
                    ? () {
                        final selectedServices = services
                            .where((service) => service['selected'])
                            .toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarPage(
                              selectedServices: selectedServices,
                              barberId: widget.barberId,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Choose Date & Time'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceCard(BuildContext context, int index, String title,
      String description, double price, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleServiceSelection(index),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: isSelected ? Colors.teal.shade100 : Colors.white,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              const SizedBox(height: 4),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          trailing:
              isSelected ? const Icon(Icons.check, color: Colors.teal) : null,
        ),
      ),
    );
  }
}
