# Notes

With this exercise my goal was to deliver a fully functional app that demonstrates my development process for mobile applications.

- Do competitive analysis by trying other apps
- Iterate quickly and build a working prototype that can be reviewed by team members and collect user feedback
- I focused on the navigation of the app and building a consistent user experience when navigating between categories, drilling down to individual categories and navigating between stories

## Navigation

- I opted to use horizontal paging to navigate between categories on the main screen and between stories in the reader
- In many competitor apps this will conflicted with the edge-swipe gesture to navigate back to the categories, so I opted for presenting the reader modally
- This created an issue where you have to use the harder to reach close button on the top to go back, to fix this I added a swipe down gesture to close the reader and also introduced the floating action bar on the bottom with a “list” button to go back
- With the action bar I also added arrows to navigate to the next and previous stories, which - along with the horizontal pan animation between stories - also helps discoverability of the horizontal paging with swipe gestures
- While the drag-down to dismiss gesture is not perfect at the moment, it’s good enough to verify the navigation concept and can be further refined to fully match platform native animations given more time

## Opportunities for improvement

As a next step I would try the following things:

- Give the story reader a more card-like look on the top with a drag indicator to better communicate the available drag-down to dismiss gesture
- Improve the drag-down gesture animation style and properly bounce the scroll animation at the top edge to match iOS standards
- Update the scroll list position of the category list when navigating back from a story to better indicate your current position in the list
- Refine the story reader block layouts
- Implement read markers and messaging screen to guide the user in the reading process and give a sense of completeness to the news reading process

## Tests

I included unit, widget and integration tests to catch regressions and make sure data parsing and all navigation buttons and gestures work properly.

## Feedback

Please don’t hesitate to give feedback via [TestFlight](https://testflight.apple.com/join/whwSKG8Z) and via the included Feedback link in the app settings.
