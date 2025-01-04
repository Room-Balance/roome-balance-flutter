import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildEnhancedRentPieChart(double rentPaid, double rentRemaining) {
  return Container(
    padding: const EdgeInsets.all(14.0), // Padding biraz azaltıldı
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14), // Köşeler çok hafif küçültüldü
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Rent Overview",
          style: TextStyle(
            fontSize: 19, // Font boyutu çok hafif küçültüldü
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 14), // Başlık ve grafik arasındaki boşluk hafif azaltıldı
        SizedBox(
          height: 180, // Pie chart'ın yüksekliği hafif küçültüldü
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: rentPaid,
                  color: Colors.green.shade400,
                  title: rentPaid > 0
                      ? 'Paid\n${rentPaid.toStringAsFixed(2)}₺'
                      : '',
                  radius: 65, // Radius çok hafif küçültüldü
                  titleStyle: const TextStyle(
                    fontSize: 15, // Font boyutu hafif küçültüldü
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        color: Colors.black26,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                PieChartSectionData(
                  value: rentRemaining > 0 ? rentRemaining : 0,
                  color: Colors.red.shade400,
                  title: rentRemaining > 0
                      ? 'Remaining\n${rentRemaining.toStringAsFixed(2)}₺'
                      : '',
                  radius: 65, // Radius çok hafif küçültüldü
                  titleStyle: const TextStyle(
                    fontSize: 15, // Font boyutu hafif küçültüldü
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        color: Colors.black26,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
              sectionsSpace: 7, // Dilimler arası boşluk çok hafif azaltıldı
              centerSpaceRadius: 35, // Merkez boşluğu hafif küçültüldü
              borderData: FlBorderData(
                show: false,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
