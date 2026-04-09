import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class TrackingEvent {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isDone;

  const TrackingEvent({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isDone = true,
  });
}

class TrackingTimeline extends StatelessWidget {
  final List<TrackingEvent> events;

  const TrackingTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isLast = index == events.length - 1;
        final isFirst = index == 0;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna da linha e ponto
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    // Linha acima do ponto (menos no primeiro)
                    if (!isFirst)
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            width: 2,
                            color:
                                event.isDone
                                    ? Pallete.primaryRed
                                    : Pallete.borderColor,
                          ),
                        ),
                      ),
                    // Ponto
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isFirst && event.isDone
                                ? Pallete.primaryRed
                                : event.isDone
                                ? Pallete.primaryRed.withOpacity(0.6)
                                : Pallete.borderColor,
                        border: Border.all(
                          color: isFirst ? Pallete.primaryRed : Colors.white,
                          width: 2,
                        ),
                        boxShadow:
                            isFirst
                                ? [
                                  BoxShadow(
                                    color: Pallete.primaryRed.withOpacity(0.4),
                                    blurRadius: 6,
                                  ),
                                ]
                                : null,
                      ),
                    ),
                    // Linha abaixo do ponto (menos no último)
                    if (!isLast)
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: 2,
                            color:
                                events[index + 1].isDone
                                    ? Pallete.primaryRed
                                    : Pallete.borderColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Conteúdo do evento
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: TextStyle(
                          fontWeight:
                              isFirst ? FontWeight.bold : FontWeight.w600,
                          fontSize: 14,
                          color:
                              isFirst
                                  ? const Color(0xFF291715)
                                  : event.isDone
                                  ? const Color(0xFF291715)
                                  : Pallete.textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Pallete.textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(event.timestamp),
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              isFirst
                                  ? Pallete.primaryRed
                                  : Pallete.textColor,
                          fontWeight:
                              isFirst ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')} às ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
