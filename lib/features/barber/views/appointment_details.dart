// data/appointments.dart

class Appointment {
  final String clientName;
  final String serviceType;
  final String timeSlot;
  final String date;
  final String barberName;
  final double price;
  final String status;

  Appointment({
    required this.clientName,
    required this.serviceType,
    required this.timeSlot,
    required this.date,
    required this.barberName,
    required this.price,
    required this.status,
  });
}

// Mock data
final List<Appointment> appointments = [
  Appointment(
    clientName: 'Abdallah',
    serviceType: 'Haircut & Beard Trim',
    timeSlot: '10:00 AM - 11:00 AM',
    date: '2024-10-13',
    barberName: 'Ahmed',
    price: 150.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Mohamed',
    serviceType: 'Hair Coloring',
    timeSlot: '12:00 PM - 1:30 PM',
    date: '2024-10-13',
    barberName: 'Omar',
    price: 200.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Fatima',
    serviceType: 'Haircut',
    timeSlot: '2:00 PM - 3:00 PM',
    date: '2024-10-13',
    barberName: 'Sara',
    price: 100.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Ali',
    serviceType: 'Beard Trim',
    timeSlot: '3:30 PM - 4:00 PM',
    date: '2024-10-13',
    barberName: 'Khaled',
    price: 50.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Sara',
    serviceType: 'Shampoo & Hair Treatment',
    timeSlot: '4:30 PM - 5:30 PM',
    date: '2024-10-13',
    barberName: 'Fatima',
    price: 80.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Youssef',
    serviceType: 'Full Hair Color',
    timeSlot: '6:00 PM - 7:00 PM',
    date: '2024-10-13',
    barberName: 'Ahmed',
    price: 220.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Nadia',
    serviceType: 'Kids Haircut',
    timeSlot: '5:00 PM - 6:00 PM',
    date: '2024-10-13',
    barberName: 'Omar',
    price: 70.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Karim',
    serviceType: 'Hair Styling',
    timeSlot: '7:30 PM - 8:30 PM',
    date: '2024-10-13',
    barberName: 'Khaled',
    price: 90.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Laila',
    serviceType: 'Men’s Haircut',
    timeSlot: '1:00 PM - 2:00 PM',
    date: '2024-10-13',
    barberName: 'Fatima',
    price: 120.0,
    status: 'Confirmed',
  ),
  Appointment(
    clientName: 'Hassan',
    serviceType: 'Shave',
    timeSlot: '11:30 AM - 12:00 PM',
    date: '2024-10-13',
    barberName: 'Ahmed',
    price: 40.0,
    status: 'Confirmed',
  ),
];
