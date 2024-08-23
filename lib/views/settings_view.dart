import 'package:flutter/material.dart';
import 'package:notification_widget_example/shared/rounded_container.dart';
import 'package:notification_widget_example/widget/profile_app_bar_widget.dart';

class ProfileOverviewView extends StatefulWidget {
  const ProfileOverviewView({super.key});

  @override
  State<ProfileOverviewView> createState() => _ProfileOverviewViewState();
}

class _ProfileOverviewViewState extends State<ProfileOverviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBarWidget(
        title: 'Settings',
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth =
                      constraints.maxWidth > 800 ? 800 : constraints.maxWidth;
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 800,
                      minWidth: cardWidth,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RoundedContainer(
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profil',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
