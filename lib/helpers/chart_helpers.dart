import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildEnhancedRentPieChart(double rentPaid, double rentRemaining) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 4,
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Rent Overview",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: rentPaid,
                    color: Colors.teal.shade400,
                    title: rentPaid > 0
                        ? 'Paid\n${rentPaid.toStringAsFixed(2)}₺'
                        : '',
                    radius: 70,
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                  PieChartSectionData(
                    value: rentRemaining > 0 ? rentRemaining : 0,
                    color: Colors.orange.shade400,
                    title: rentRemaining > 0
                        ? 'Remaining\n${rentRemaining.toStringAsFixed(2)}₺'
                        : '',
                    radius: 70,
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ],
                sectionsSpace: 6,
                centerSpaceRadius: 40,
                borderData: FlBorderData(
                  show: false,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            "Total Overview",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}
