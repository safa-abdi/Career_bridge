import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () {},
          splashRadius: 24,
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Hi, William",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Developer, google, etc",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            // Tips Widget
            HeadlineWidget(title: "Tips for you"),
            SizedBox(height: 16),
            TipsWidget(),

            // Category
            SizedBox(height: 24),
            HeadlineWidget(title: "Category"),
            SizedBox(height: 16),
            CategoryWidget(),

            // Recent Job
            SizedBox(height: 24),
            HeadlineWidget(title: "Recent Jobs"),
            SizedBox(height: 16),
            RecentJobWidget(),
          ],
        ),
      ),
    );
  }
}

// Widget personnalisé pour les titres
class HeadlineWidget extends StatelessWidget {
  final String title;
  const HeadlineWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

// Widget de conseils
class TipsWidget extends StatelessWidget {
  const TipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blueAccent.withOpacity(0.1),
      child: Center(
        child: Text(
          "Some useful tips for you!",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

// Widget pour les catégories
class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3,
      children: List.generate(4, (index) {
        return Card(
          child: Center(
            child: Text(
              "Category ${index + 1}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
      }),
    );
  }
}

// Widget pour les emplois récents
class RecentJobWidget extends StatelessWidget {
  const RecentJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.work),
            title: Text("Job Title ${index + 1}"),
            subtitle: Text("Company Name ${index + 1}"),
          ),
        );
      }),
    );
  }
}
