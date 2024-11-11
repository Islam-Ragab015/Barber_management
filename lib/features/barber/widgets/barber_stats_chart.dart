import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class BarberStatsChart extends StatelessWidget {
  const BarberStatsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Barber Statistics Overview',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Services Performance',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.teal[600],
            ),
          ),
          const SizedBox(height: 10),
          _barChart(),
          const SizedBox(height: 30),
          Text(
            'Service Distribution',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.teal[600],
            ),
          ),
          const SizedBox(height: 10),
          _pieChart(),
        ],
      ),
    );
  }

  Widget _barChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(fromY: 0, toY: 8, color: Colors.teal)
              ]),
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(fromY: 0, toY: 10, color: Colors.orange)
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(fromY: 0, toY: 14, color: Colors.blue)
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(fromY: 0, toY: 15, color: Colors.purple)
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(fromY: 0, toY: 13, color: Colors.red)
              ]),
            ],
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text('Cuts');
                      case 1:
                        return const Text('Trims');
                      case 2:
                        return const Text('Colors');
                      case 3:
                        return const Text('Others');
                      case 4:
                        return const Text('Total');
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: const FlGridData(show: true),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String service;
                  switch (group.x.toInt()) {
                    case 0:
                      service = 'Cuts';
                      break;
                    case 1:
                      service = 'Trims';
                      break;
                    case 2:
                      service = 'Colors';
                      break;
                    case 3:
                      service = 'Others';
                      break;
                    case 4:
                      service = 'Total';
                      break;
                    default:
                      service = '';
                  }
                  return BarTooltipItem(
                    '$service\n${rod.toY}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pieChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 200,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 40,
                color: Colors.teal,
                title: 'Haircut',
                titleStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartSectionData(
                value: 30,
                color: Colors.orange,
                title: 'Beard Trim',
                titleStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartSectionData(
                value: 15,
                color: Colors.blue,
                title: 'Coloring',
                titleStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartSectionData(
                value: 15,
                color: Colors.purple,
                title: 'Others',
                titleStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            centerSpaceRadius: 40,
            sectionsSpace: 5,
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}
