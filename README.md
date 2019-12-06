# Mars Explorer

A simple application for browsing information about the Mars rover expeditions as well as the pictures that the rovers took on their missions.

This application uses the freely available API that NASA provides for browsing rover image data. This API can be viewed at [https://api.nasa.gov](https://api.nasa.gov).

## Build Instructions

This app does not use any 3rd party dependencies, so to build the app open the `Mars Explorer.xcodeproj` project file, select the Mars Rover build scheme and build.

Additionally, the API key needed to access NASA's API has been provided in the project already.

## Additional Information

The initial screen in the app is a list of rovers that have explored Mars. Tap on a rover to view more information about its mission.

In the rover detail screen, tap on "Show All Cameras" to expand the list of cameras.

Tap on "All Photos" or a camera to browse the list of images for that rover or camera.

The photo list screen will display a list of photos in reverse chronological order. Scrolling to the bottom of the list will download more photos. Tap on a photo to view all information about that photo as well as see the photo in a larger format. Tap on the camera's acronym to see its full name.
