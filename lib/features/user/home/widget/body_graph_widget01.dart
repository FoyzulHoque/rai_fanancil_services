import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/themes/app_colors.dart';

class BodyGraphWidget01 extends StatelessWidget {
  const BodyGraphWidget01({
    super.key,
    required this.title,                    // গ্রাফের উপরে টাইটেল (যেমন: "Cash Flow Trend")
    required this.monthlyData,             // API থেকে আসা মূল ডাটা (মাস + অ্যামাউন্ট)
    this.lineColor = Colors.blue,          // লাইনের কালার (ডিফল্ট নীল)
    this.fillOpacity = 0.4,                // লাইনের নিচে ফিলের স্বচ্ছতা (0.0 = পুরোপুরি স্বচ্ছ, 1.0 = পুরোপুরি অস্বচ্ছ)
  });

  final String title;

  /// API থেকে আসা ডাটার ফরম্যাট উদাহরণ:
  /// [{'month': 'Jan', 'amount': 4500}, {'month': 'Feb', 'amount': 4300}, ...]
  final List<Map<String, dynamic>> monthlyData;

  final Color lineColor;
  final double fillOpacity;

  @override
  Widget build(BuildContext context) {
    // যদি কোনো ডাটা না থাকে তাহলে "No data available" দেখাবে
    if (monthlyData.isEmpty) {
      return Card(
        color: AppColors.secondaryColors,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text("No data available")),
        ),
      );
    }

    // FlSpot লিস্ট তৈরি করা → প্রতিটি পয়েন্টের X = মাসের ইনডেক্স (0,1,2...), Y = অ্যামাউন্ট
    final List<FlSpot> spots = monthlyData
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), (entry.value['amount'] as num).toDouble()))
        .toList();

    // মাসের নামগুলো আলাদা লিস্টে রাখা → নিচে X-axis-এ লেবেল দেখানোর জন্য
    final List<String> months = monthlyData
        .map<String>((data) => data['month'] as String)
        .toList();

    // Y-axis-এর সর্বোচ্চ ভ্যালু অটো ক্যালকুলেট করা + একটু অতিরিক্ত স্পেস (প্যাডিং)
    final double maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 500;

    return Card(
      elevation: 4, // কার্ডের ছায়া
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // গোলাকার কর্নার
      child: Padding(
        padding: const EdgeInsets.all(20), // কার্ডের ভিতরে স্পেসিং
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // গ্রাফের টাইটেল
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20), // টাইটেল আর গ্রাফের মাঝে গ্যাপ

            // গ্রাফের মূল অংশ
            SizedBox(
              height: 250, // গ্রাফের উচ্চতা ফিক্সড
              child: LineChart(
                LineChartData(
                  // হরিজন্টাল গ্রিড লাইন (ড্যাশড)
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false, // ভার্টিকাল লাইন বন্ধ
                    horizontalInterval: (maxY / 4).roundToDouble(), // ৪টা সমান গ্রিড লাইন
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                      dashArray: [8, 4], // ড্যাশড লাইন
                    ),
                  ),

                  // X এবং Y অক্ষের লেবেল
                  titlesData: FlTitlesData(
                    // বামে Y-axis এর ভ্যালু (যেমন 0, 1500, 3000...)
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50, // লেবেলের জন্য জায়গা
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    // নিচে X-axis এ মাসের নাম (Jan, Feb...)
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1, // প্রতিটি পয়েন্টে লেবেল
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= months.length) return const Text('');
                          return Text(
                            months[index],
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),

                  borderData: FlBorderData(show: false), // গ্রাফের বর্ডার বন্ধ
                  minX: 0, // X-axis শুরু
                  maxX: (monthlyData.length - 1).toDouble(), // X-axis শেষ (ডাটার সংখ্যা অনুযায়ী)
                  minY: 0, // Y-axis শুরু ০ থেকে
                  maxY: maxY, // Y-axis সর্বোচ্চ ভ্যালু + প্যাডিং

                  // মূল লাইন চার্টের ডাটা
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots, // উপরে তৈরি করা পয়েন্টস
                      isCurved: true, // স্মুথ কার্ভ (সোজা লাইন নয়)
                      curveSmoothness: 0.35, // কতটা স্মুথ হবে
                      color: lineColor, // লাইনের কালার
                      barWidth: 4, // লাইনের মোটা
                      isStrokeCapRound: true, // লাইনের প্রান্ত গোলাকার
                      dotData: const FlDotData(show: false), // পয়েন্টে ডট দেখাবে না
                      // লাইনের নিচে গ্র্যাডিয়েন্ট ফিল
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            lineColor.withOpacity(fillOpacity), // উপরে বেশি অস্বচ্ছ
                            lineColor.withOpacity(0.0),         // নিচে পুরোপুরি স্বচ্ছ
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],

                  // লাইনে টাচ করলে টুলটিপ দেখাবে (ডিফল্ট true রাখলাম)
                  lineTouchData: const LineTouchData(enabled: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}