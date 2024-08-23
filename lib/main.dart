import 'package:flutter/material.dart';
import 'package:notification_widget_example/views/settings_view.dart';
import 'package:notification_widget_example/widget/notification_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Widget Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Notification Widget Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileOverviewView(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth =
                constraints.maxWidth > 800 ? 800 : constraints.maxWidth;
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 800,
                minWidth: cardWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NotificationWidget(
                    type: NotificationType.info,
                    title: 'Info notification',
                    description: 'This is an info notification.',
                    name: 'info_notification',
                    onTap: () {
                      debugPrint('Notification tapped');
                    },
                  ),
                  const SizedBox(height: 16),
                  NotificationWidget(
                    type: NotificationType.warning,
                    title: 'Warning notification',
                    name: cardWidth <= 800 ? 'warning_notification' : null,
                    description: 'This is a warning notification.',
                    onTap: () {
                      debugPrint('Warning notification tapped');
                    },
                  ),
                  const SizedBox(height: 16),
                  NotificationWidget(
                    type: NotificationType.danger,
                    title: 'Danger notification',
                    description: 'This is an danger notification. ',
                    onTap: () {
                      debugPrint('Danger notification tapped');
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
