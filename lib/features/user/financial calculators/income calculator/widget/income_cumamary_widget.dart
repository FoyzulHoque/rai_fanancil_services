import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeSourcesChartCard extends StatelessWidget {
  final double employmentIncome;
  final double rentalIncome;

  const IncomeSourcesChartCard({
    super.key,
    required this.employmentIncome,
    required this.rentalIncome,
  });

  @override
  Widget build(BuildContext context) {
    final maxIncome = [employmentIncome, rentalIncome].reduce((a, b) => a > b ? a : b);
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          const Text(
            'Income Sources',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          /// Chart
          SizedBox(
            height: 220,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// Y Axis
                _YAxis(),

                const SizedBox(width: 8),

                /// Bars + Grid
                Expanded(
                  child: Stack(
                    children: [
                      /// Grid lines
                      const _HorizontalGrid(),

                      /// Bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Bar(
                            label: 'Employment',
                            value: employmentIncome,
                            maxValue: maxIncome,
                            color: const Color(0xFF0E77B7),
                            formatter: formatter,
                          ),
                          _Bar(
                            label: 'Rental',
                            value: rentalIncome,
                            maxValue: maxIncome,
                            color: const Color(0xFF27B0E6),
                            formatter: formatter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Legend
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              _LegendItem(
                color: const Color(0xFF0E77B7),
                text: 'Employment Income',
                value: formatter.format(employmentIncome),
              ),
              _LegendItem(
                color: const Color(0xFF27B0E6),
                text: 'Rental Income',
                value: formatter.format(rentalIncome),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* -------------------- Y AXIS -------------------- */

class _YAxis extends StatelessWidget {
  const _YAxis();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _AxisText('100000'),
        _AxisText('75000'),
        _AxisText('50000'),
        _AxisText('25000'),
        _AxisText('0'),
      ],
    );
  }
}

class _AxisText extends StatelessWidget {
  final String text;
  const _AxisText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }
}

/* -------------------- GRID -------------------- */

class _HorizontalGrid extends StatelessWidget {
  const _HorizontalGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
            (_) => Divider(
          color: Colors.grey.shade300,
          thickness: 1,
          height: 1,
        ),
      ),
    );
  }
}

/* -------------------- BAR -------------------- */

class _Bar extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;
  final NumberFormat formatter;

  const _Bar({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final barHeight = (value / maxValue) * 160;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          formatter.format(value),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: barHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

/* -------------------- LEGEND -------------------- */

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final String value;

  const _LegendItem({
    required this.color,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$text  $value',
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
