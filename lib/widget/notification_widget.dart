import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NotificationType { danger, warning, info }

class NotificationWidget extends StatefulWidget {
  final NotificationType type;
  final String title;
  final String description;
  final String? name;
  final Function()? onTap;

  const NotificationWidget({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    this.onTap,
    this.name,
  }) : assert(
          type != NotificationType.info || name != null,
          'If the NotificationType is info, the name attribute is required.',
        );

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool _isVisible = true;
  double _opacity = 1.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.type == NotificationType.info && widget.name != null) {
        await _checkVisibility();
      }
    });
    super.initState();
  }

  Future<void> _checkVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVisible = prefs.getBool(widget.name!) ?? true;
    });
  }

  Future<void> _hideNotification() async {
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.name!, false);
    await _addHiddenNotification(widget.name!);
    setState(() {
      _isVisible = false;
    });
  }

  Future<void> _addHiddenNotification(String name) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> hiddenNotifications =
        prefs.getStringList('hidden_notifications') ?? [];
    hiddenNotifications.add(name);
    await prefs.setStringList('hidden_notifications', hiddenNotifications);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    Color backgroundColor;
    Color textColor;

    switch (widget.type) {
      case NotificationType.danger:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
      case NotificationType.warning:
        backgroundColor = Colors.yellow;
        textColor = Colors.black;
        break;
      case NotificationType.info:
        backgroundColor = Colors.blue;
        textColor = Colors.white;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 500),
          child: Card(
            margin: const EdgeInsets.all(0),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _getIconData(widget.type),
                    color: textColor,
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.type == NotificationType.info ||
                      (widget.type == NotificationType.warning &&
                          widget.name != null))
                    IconButton(
                      onPressed: _hideNotification,
                      icon: Icon(
                        Icons.close,
                        color: textColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(NotificationType type) {
    switch (type) {
      case NotificationType.danger:
        return Icons.error;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.info:
        return Icons.info;
    }
  }
}

// Function to reset all notifications
Future<void> resetAllNotificationsWidgets() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> hiddenNotifications =
      prefs.getStringList('hidden_notifications') ?? [];
  for (String name in hiddenNotifications) {
    await prefs.remove(name);
  }
  await prefs.remove('hidden_notifications');
}
