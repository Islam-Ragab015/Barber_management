import 'package:barber/features/appoinments/calendar_page.dart';
import 'package:barber/features/favourite/favorites_provide.dart';
import 'package:barber/features/location/location_screan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SalonDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String barberId;

  const SalonDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.barberId,
  });

  @override
  _SalonDetailPageState createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();

  List<bool> selectedServices = List.filled(4, false);
  double? userRating = 0.0;

  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);
    final isFavorited = provider.isFavorite({
      'title': widget.title,
      'subtitle': widget.subtitle,
    });

    if (isFavorited) {
      provider.removeFavorite({
        'title': widget.title,
        'subtitle': widget.subtitle,
      });
    } else {
      provider.addFavorite({
        'title': widget.title,
        'subtitle': widget.subtitle,
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToAppointmentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          selectedServices: const [],
          barberId: widget.barberId,
        ),
      ),
    );
  }

  void _showRatingMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your rating!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<FavoritesProvider>(context);
    final isAnyServiceSelected = selectedServices.any((selected) => selected);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: const Text(
          'Kadanama Salon',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          // IconButton(
          //   icon: Icon(
          //     provider.isFavorite({
          //       'title': widget.title,
          //       'subtitle': widget.subtitle,
          //     })
          //         ? Icons.favorite
          //         : Icons.favorite_border,
          //     color: provider.isFavorite({
          //       'title': widget.title,
          //       'subtitle': widget.subtitle,
          //     })
          //         ? Colors.red
          //         : Colors.grey,
          //   ),
          //   onPressed: _toggleFavorite,
          // ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Hero(
                      tag: 'salon_image',
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const live_location(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/map1.jpg',
                          height: screenHeight * 0.25, // Responsive height
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Image.asset(
                      //   'assets/images/map1.jpg',
                      //   height: screenHeight * 0.25, // Responsive height
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.black54), // Responsive font size
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: userRating!,
                        minRating: 0,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: screenWidth * 0.07, // Responsive icon size
                        unratedColor: Colors.grey[300],
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            userRating = rating;
                          });
                        },
                      ),
                      ScaleTransition(
                        scale: _buttonScaleAnimation,
                        child: ElevatedButton(
                          onPressed: userRating! > 0
                              ? () {
                                  _showRatingMessage();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.green),
                      const SizedBox(width: 4),
                      const Text(
                        'Open Now',
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      const SizedBox(width: 8),
                      const Text('9:00 AM - 7:00 PM',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        onPressed: () => _scrollToSection(_aboutKey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _sectionButton('Services', _servicesKey),
                      _sectionButton('Reviews', _reviewsKey),
                      _sectionButton('About', _aboutKey),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader('Select Services'),
                  Container(
                    key: _servicesKey,
                    child: Column(
                      children: [
                        _serviceTile(0, 'Full Set',
                            '60 min | Titanium Manicure', '\$100.00'),
                        _serviceTile(1, 'Hair Cut', '45 min | Stylish Hair Cut',
                            '\$80.00'),
                        _serviceTile(2, 'Beard Grooming',
                            '30 min | Beard Trim and Shape', '\$60.00'),
                        _serviceTile(3, 'Relaxation Massage',
                            '60 min | Full Body', '\$120.00'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader('Reviews'),
                  Container(
                    key: _reviewsKey,
                    child: Column(
                      children: [
                        _reviewTile('Mohamed Hassan',
                            'Amazing service and friendly staff!', 5),
                        _reviewTile('Abdallah Abdalmonem',
                            'Great experience, highly recommended!', 4),
                        _reviewTile('Momen Raafat',
                            'Very professional and clean salon.', 5),
                        _reviewTile('Islam Ragab',
                            'Amazing service and friendly staff!', 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader('About'),
                  Container(
                    key: _aboutKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _openingHoursRow('Monday', 'Closed', Colors.grey),
                        _openingHoursRow(
                            'Tuesday', '9:00 AM - 7:00 PM', Colors.green),
                        _openingHoursRow(
                            'Wednesday', '9:00 AM - 7:00 PM', Colors.green),
                        _openingHoursRow(
                            'Thursday', '9:00 AM - 7:00 PM', Colors.green),
                        _openingHoursRow(
                            'Friday', '9:00 AM - 7:00 PM', Colors.green),
                        _openingHoursRow(
                            'Saturday', '9:00 AM - 7:00 PM', Colors.green),
                        _openingHoursRow('Sunday', 'Closed', Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Location:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        // ClipRRect(
                        //   key: _locationKey,
                        //   borderRadius: BorderRadius.circular(12.0),
                        //   child: ElevatedButton(onPressed: (){
                        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const live_location()));
                        //   }, child: Image.asset(
                        //     'assets/images/map1.jpg',
                        //     width: double.infinity,
                        //     fit: BoxFit.cover,
                        //     height: screenHeight * 0.5, // Responsive height
                        //   ),)
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              color: Colors.white,
              child: ElevatedButton(
                onPressed: isAnyServiceSelected ? _goToAppointmentPage : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionButton(String title, GlobalKey key) {
    return ElevatedButton(
      onPressed: () => _scrollToSection(key),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
      ),
      child: Text(title),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _serviceTile(int index, String title, String subtitle, String price) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(price),
      leading: Checkbox(
        value: selectedServices[index],
        onChanged: (bool? value) {
          setState(() {
            selectedServices[index] = value!;
          });
        },
      ),
    );
  }

  Widget _reviewTile(String reviewer, String review, double rating) {
    return ListTile(
      title: Text(reviewer),
      subtitle: Text(review),
      trailing: RatingBarIndicator(
        rating: rating,
        itemCount: 5,
        itemSize: 20.0,
        unratedColor: Colors.grey[300],
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget _openingHoursRow(String day, String hours, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day, style: const TextStyle(fontSize: 16)),
        Text(hours, style: TextStyle(fontSize: 16, color: color)),
      ],
    );
  }
}
