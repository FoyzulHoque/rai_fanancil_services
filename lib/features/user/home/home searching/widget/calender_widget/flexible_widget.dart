import 'package:flutter/material.dart';

class FlexibleWidget extends StatelessWidget {
  FlexibleWidget({super.key});

  final List<Map<String, String>> months = _generateNext12Months();

  static List<Map<String, String>> _generateNext12Months() {
    final List<Map<String, String>> list = [];
    final DateTime now = DateTime.now();

    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    for (int i = 0; i < 12; i++) {
      DateTime targetDate = DateTime(now.year, now.month + i);
      if (targetDate.month > 12) {
        targetDate = DateTime(now.year + 1, targetDate.month - 12);
      }

      list.add({
        "month": monthNames[targetDate.month - 1],
        "year": targetDate.year.toString(),
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        const SizedBox(height: 16),
        const Text(
          "Stay for a week",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _optionButton("Weekend")),
            const SizedBox(width: 12),
            Expanded(child: _optionButton("Week")),
            const SizedBox(width: 12),
            Expanded(child: _optionButton("Month")),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 16),
        const Text(
          "Go anytime",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        // Use Expanded with ListView instead
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GridView.builder(
              shrinkWrap: false,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: months.length,
              itemBuilder: (context, index) {
                final month = months[index]['month']!;
                final year = months[index]['year']!;
                return _anytimeCard(month, year);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _anytimeCard(String month, String year) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/nav3.png",
            width: 36,
            height: 36,
            color: Colors.amber.shade700,
          ),
          const SizedBox(height: 12),
          Text(
            month,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            year,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}