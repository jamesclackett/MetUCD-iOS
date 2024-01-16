# MetUCD

---

MetUCD is a showcase of SwiftUI for iOS development for my CompSci MSc Swift module.

#### _The project consisted of two parts:_

#### Part 1:

The objective of Part 1 was to build a weather forecast application that can search for
locations using a geo coder and display weather information about that location to the user.

A Weather View was created that displays weather information to users.
On loading of the application, the WeatherView is passed a WeatherViewModel
environment variable. An environment variable was used so that sub-views can easily access
the same view model object.

#### Part 2:

The objective of Part 2 was to improve upon the weather forecast application. The user
would be presented with a Map of their current location. This map would allow them to
select and search for new locations. For any given location, the user would see a summary of
the weather and have the option to view more detailed info by clicking on a widget.

Core Location and MapKit were introduced in this part. The application
contains a Map that allows the user to view a weather forecast for their current location, or
a location they have selected. Users can select news location via a search bar or by touching
the map. A summary of the current forecast is shown on a widget, as well as a small
temperature annotation. More detailed weather information can be found by tapping on the
widget, which uses a SwiftUI sheet to display a WeatherView.

**_To run MetUCD (either part 1 or 2), install the Xcode IDE on MacOS(Ventura or above) and run it in the IDE's device simulator_**

---

### User Interface (part 1):

<img width="693" alt="image" src="https://github.com/jamesclackett/iOS-Weather-App/assets/55019466/70846e1b-80f9-4502-9898-570a8a4e3f28">

---

### User Interface (part 2):

<img width="693" alt="image" src="https://github.com/jamesclackett/iOS-Weather-App/assets/55019466/1e30e478-0abe-4fd9-80f7-f0df215e6750">
<img width="693" alt="image" src="https://github.com/jamesclackett/iOS-Weather-App/assets/55019466/accb5eb6-a6db-4701-86cb-17b687a63491">

---

