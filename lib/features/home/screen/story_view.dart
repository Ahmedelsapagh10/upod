import 'package:flutter/material.dart';
import 'package:story/story.dart';

import '../data/model/story_and_slider_model.dart';

class FullScreenStory extends StatelessWidget {
  final List<Story> stories; // Your story data
  final int initialPageIndex;

  FullScreenStory({
    required this.stories,
    required this.initialPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          // Get the current story based on pageIndex and storyIndex
          final story = stories[pageIndex];

          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Positioned.fill(
                child: Image.network(
                  story.image ?? '', // Display the story image
                  // fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              story.image!), // Use the same image as avatar
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      story.by ?? '', // Display the "by" field as the username
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close button
                },
              ),
            ),
          );
        },
        pageLength: stories.length, // Total number of stories
        storyLength: (int pageIndex) {
          // Each story has only one page (image)
          return 1;
        },
        onPageLimitReached: () {
          Navigator.pop(context); // Exit when all stories are viewed
        },
        initialPage: initialPageIndex, // Start from the selected story
      ),
    );
  }
}
