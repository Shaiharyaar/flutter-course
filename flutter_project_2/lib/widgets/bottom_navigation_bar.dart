import 'package:flutter/material.dart';
import 'package:flutter_project_2/providers/current_index_nav_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexNavProvider);
    return NavigationBar(
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: "Home",
            enabled: true,
            selectedIcon: Icon(Icons.home_filled, color: Colors.green)),
        NavigationDestination(
            icon: Icon(Icons.grid_view),
            label: "Categories",
            selectedIcon: Icon(Icons.grid_view, color: Colors.green)),
        NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
            selectedIcon: Icon(Icons.person, color: Colors.green)),
      ],
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: currentIndex,
      indicatorColor: Colors.transparent,
      surfaceTintColor: Colors.green,
      onDestinationSelected: (value) {
        ref
            .read(currentIndexNavProvider.notifier)
            .update((state) => state = value);
      },
    );
  }
}
