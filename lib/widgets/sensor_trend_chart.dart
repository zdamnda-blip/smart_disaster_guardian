import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/history_point_model.dart';
import '../theme/app_colors.dart';

class SensorTrendChart extends StatelessWidget {
  final List<HistoryPointModel> history;

  const SensorTrendChart({
    super.key,
    required this.history,
  });

  bool _isMovementDetected(String pergerakanTanah) {
    
    final value = pergerakanTanah.toLowerCase().trim();
    return value.isNotEmpty && value != "tidak terdeteksi";
  }

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(
        child: Text(
          "Belum ada data riwayat",
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    final kelembabanSpots = <FlSpot>[];
    final curahHujanSpots = <FlSpot>[];

    for (int i = 0; i < history.length; i++) {
      kelembabanSpots.add(FlSpot(i.toDouble(), history[i].kelembabanTanah));
      curahHujanSpots.add(FlSpot(i.toDouble(), history[i].curahHujan));
    }

    final labelInterval = (history.length / 5).ceil().clamp(1, history.length);

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (history.length - 1).toDouble(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.divider,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 20,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: labelInterval.toDouble(),
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= history.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    history[index].time,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final isKelembaban = spot.barIndex == 0;
                return LineTooltipItem(
                  isKelembaban
                      ? "Kelembaban: ${spot.y.toStringAsFixed(0)}%"
                      : "Curah Hujan: ${spot.y.toStringAsFixed(0)} mm",
                  const TextStyle(color: Colors.white, fontSize: 11),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: kelembabanSpots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                final detected = _isMovementDetected(
                  history[index].pergerakanTanah,
                );

                if (detected) {
                  return _TrianglePainter(color: AppColors.siaga);
                }

                return FlDotCirclePainter(
                  radius: 3,
                  color: Colors.blue,
                  strokeWidth: 0,
                );
              },
            ),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: curahHujanSpots,
            isCurved: true,
            color: Colors.teal,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends FlDotPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const size = 5.0;
    final path = Path()
      ..moveTo(offsetInCanvas.dx, offsetInCanvas.dy - size)
      ..lineTo(offsetInCanvas.dx - size, offsetInCanvas.dy + size)
      ..lineTo(offsetInCanvas.dx + size, offsetInCanvas.dy + size)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  Size getSize(FlSpot spot) => const Size(10, 10);

  @override
  Color get mainColor => color;

  @override
  List<Object?> get props => [color];

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) => this;
}