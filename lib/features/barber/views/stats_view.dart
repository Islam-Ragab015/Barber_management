// presentation/views/stats_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Make the body scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Stats Overview',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCharts(), // Remove Expanded to allow scroll
          ],
        ),
      ),
    );
  }

  Widget _buildCharts() {
    return Column(
      children: [
        SizedBox(
          // Use SizedBox instead of Expanded
          height: 300, // Set a fixed height for the bar chart
          child: _barChart(),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // Use SizedBox instead of Expanded
          height: 300, // Set a fixed height for the pie chart
          child: _pieChart(),
        ),
      ],
    );
  }

  Widget _barChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: [
          BarChartGroupData(
              x: 0, barRods: [BarChartRodData(toY: 15, color: Colors.teal)]),
          BarChartGroupData(
              x: 1, barRods: [BarChartRodData(toY: 20, color: Colors.orange)]),
          BarChartGroupData(
              x: 2, barRods: [BarChartRodData(toY: 10, color: Colors.blue)]),
          BarChartGroupData(
              x: 3, barRods: [BarChartRodData(toY: 25, color: Colors.purple)]),
          BarChartGroupData(
              x: 4, barRods: [BarChartRodData(toY: 30, color: Colors.green)]),
        ],
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        gridData: const FlGridData(show: false),
      ),
    );
  }

  Widget _pieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, color: Colors.teal, title: 'Haircuts'),
          PieChartSectionData(
              value: 35, color: Colors.orange, title: 'Beard Trims'),
          PieChartSectionData(value: 15, color: Colors.blue, title: 'Coloring'),
          PieChartSectionData(value: 10, color: Colors.purple, title: 'Others'),
        ],
        centerSpaceRadius: 40,
        sectionsSpace: 5,
      ),
    );
  }
}
