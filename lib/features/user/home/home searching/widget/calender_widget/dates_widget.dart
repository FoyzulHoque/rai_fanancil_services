import 'package:flutter/material.dart';

class DatesWidget extends StatefulWidget {
  const DatesWidget({super.key, this.isSelect});
  final bool? isSelect;

  @override
  _DatesWidgetState createState() => _DatesWidgetState();
}

class _DatesWidgetState extends State<DatesWidget> {
  // Track selected dates
  Set<String> selectedDates = {};

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.isSelect ?? false;  // Use a default value for isSelect if it's null

    return Column(
      children: [
        // Custom Calendar Layout (you can extend with actual calendar data)
        Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              children: [
                for (var day in ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(day, textAlign: TextAlign.center),
                  ),
              ],
            ),
            // Add rows for dates, this is static data, you can update it based on the actual date logic.
            _buildDateRow(['1', '2', '3', '4', '5', '6', '7']),
            _buildDateRow(['8', '9', '10', '11', '12', '13', '14']),
            _buildDateRow(['15', '16', '17', '18', '19', '20', '21']),
            _buildDateRow(['22', '23', '24', '25', '26', '27', '28']),
            _buildDateRow(['29', '30', '31', '', '', '', '']), // Add empty cells to fill the row
          ],
        ),
        Divider(),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      isSelected ? Colors.black : Colors.grey)),
              child: Text("Exact dates"),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      isSelected ? Colors.black : Colors.grey)),
              child: Text("± 1 day"),
            ),
            Spacer(),

            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      isSelected ? Colors.black : Colors.grey)),
              child: Text("± 2 days"),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  // Helper function to build date rows
  TableRow _buildDateRow(List<String> dates) {
    // Ensure the row always has 7 items
    while (dates.length < 7) {
      dates.add('');  // Add empty strings to fill the row
    }

    return TableRow(
      children: dates.map((date) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (date.isNotEmpty) {
                if (selectedDates.contains(date)) {
                  selectedDates.remove(date); // Deselect date
                } else {
                  selectedDates.add(date); // Select date
                }
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: selectedDates.contains(date)
                  ? Colors.blueAccent
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selectedDates.contains(date)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
