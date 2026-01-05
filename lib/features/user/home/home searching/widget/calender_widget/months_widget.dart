import 'package:flutter/material.dart';

class MonthsWidget extends StatefulWidget {
  final int months;
  final int totalMonths;
  final DateTime? startDate;
  final VoidCallback? onEdit;

  const MonthsWidget({
    super.key,
    required this.months,
    this.totalMonths = 12,
    this.startDate,
    this.onEdit,
  });

  @override
  State<MonthsWidget> createState() => _MonthsWidgetState();
}

class _MonthsWidgetState extends State<MonthsWidget> {
  DateTime currentDate = DateTime.now();
  String? selectedStartMonthYear;
  String? selectedEndMonthYear;

  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Store the progress locally
  int _currentMonths = 0;

  // Generate a list of month-year strings for the dropdown
  List<String> get monthYearList {
    return List.generate(12, (index) {
      DateTime targetDate = DateTime(currentDate.year, index + 1);
      return '${monthNames[targetDate.month - 1]} ${targetDate.year}';
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the default selected value to current month and year
    selectedStartMonthYear =
        '${monthNames[currentDate.month - 1]} ${currentDate.year}';
    selectedEndMonthYear = selectedStartMonthYear;
    _currentMonths = widget.months; // Initialize local variable
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        (_currentMonths / widget.totalMonths).clamp(0.0, 1.0);
    final DateTime displayStartDate =
        widget.startDate ?? DateTime(DateTime.now().year, 7, 1);
    final String startText = 'Starting ${_formatDate(displayStartDate)}';
    final double widgetSize = MediaQuery.of(context).size.width * 0.75;
    const double ringRadius = 130.0; // outer ring radius
    const double strokeWidth = 28.0;
    const double innerCircleSize = 180.0;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dropdown section with proper constraints
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start Month Dropdown - Flexible with constraints
                Flexible(
                  fit: FlexFit.tight,
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: SizedBox(
                      width: double.infinity, // Take full available width
                      child: DropdownButtonFormField<String>(
                        isExpanded: true, // Important for dropdown to work properly
                        value: selectedStartMonthYear,
                        items: monthYearList.map((monthYear) {
                          return DropdownMenuItem<String>(
                            value: monthYear,
                            child: Text(
                              monthYear,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedStartMonthYear = value;
                            _updateProgress();
                          });
                          print('Selected Start Month-Year: $selectedStartMonthYear');
                        },
                        decoration: const InputDecoration(
                          labelText: 'Start Month',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // End Month Dropdown - Flexible with constraints
                Flexible(
                  fit: FlexFit.tight,
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: SizedBox(
                      width: double.infinity, // Take full available width
                      child: DropdownButtonFormField<String>(
                        isExpanded: true, // Important for dropdown to work properly
                        value: selectedEndMonthYear,
                        items: monthYearList.map((monthYear) {
                          return DropdownMenuItem<String>(
                            value: monthYear,
                            child: Text(
                              monthYear,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedEndMonthYear = value;
                            _updateProgress();
                          });
                          print('Selected End Month-Year: $selectedEndMonthYear');
                        },
                        decoration: const InputDecoration(
                          labelText: 'End Month',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Progress circle section
          Center(
            child: SizedBox(
              width: widgetSize,
              height: widgetSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Light gray background track
                  SizedBox(
                    width: ringRadius * 2,
                    height: ringRadius * 2,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: strokeWidth,
                      color: Colors.grey.shade300,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  // Amber progress arc
                  SizedBox(
                    width: ringRadius * 2,
                    height: ringRadius * 2,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: strokeWidth,
                      backgroundColor: Colors.transparent,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.amber),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  // White dot at the end of progress
                  if (progress > 0 && progress < 1)
                    Transform.rotate(
                      angle: progress * 2 * 3.14159, // clockwise from right
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: ringRadius - strokeWidth / 2 - 16),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  // Center white circle with text
                  Container(
                    width: innerCircleSize,
                    height: innerCircleSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_currentMonths',
                          style: const TextStyle(
                            fontSize: 64, // Reduced from 80
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.1,
                          ),
                        ),
                        const Text(
                          'months',
                          style: TextStyle(
                            fontSize: 22, // Reduced from 26
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8), // Reduced from 16
                        Text(
                          startText,
                          style: const TextStyle(
                            fontSize: 14, // Reduced from 16
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onEdit,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 14, // Reduced from 16
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${monthNames[date.month - 1]} ${date.day}';
  }

  void _updateProgress() {
    if (selectedStartMonthYear != null && selectedEndMonthYear != null) {
      final startParts = selectedStartMonthYear!.split(' ');
      final endParts = selectedEndMonthYear!.split(' ');

      if (startParts.length == 2 && endParts.length == 2) {
        final startMonth = monthNames.indexOf(startParts[0]) + 1;
        final startYear = int.tryParse(startParts[1]) ?? currentDate.year;
        final endMonth = monthNames.indexOf(endParts[0]) + 1;
        final endYear = int.tryParse(endParts[1]) ?? currentDate.year;

        // Calculate the difference in months
        final monthsDifference =
            (endYear * 12 + endMonth) - (startYear * 12 + startMonth);

        setState(() {
          // Update the state variable, ensuring it's not negative
          _currentMonths = monthsDifference >= 0 ? monthsDifference : 0;
        });
      }
    }
  }
}