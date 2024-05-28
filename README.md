# Business Page App

## About:
- This is a single screen app that displays the name and business hours of a store. 
- The accordion view shows a summary of the current open state, and can be expanded to see more information on timings. 
- This project demonstrates an app created using Swift UI, with subtle UI customization and associated logic related to date and time processing.

## App Highlights:
- All photos are displayed in a visually appealing layout within a tableview
- On tapping a photo, a detail screen opens in a modal view to show the full resolution image and caption
- Error alert is displayed if there's an issue fetching photos

## Assumptions:
- The background image won't change and can be contained within the app bundle.
- The app is optimized for English language and US date-time formats.
- The time string will always be in range "00:00:00" through "24:00:00".
- The hours and minutes will be taken into account, but we can ignore the seconds as accuracy in seconds may not be necessary for store timings.
- The view menu button is not functional.

## Process and decisions:
- The app is built using SwifUI and utilized the mock up UI and criteria from the FIGMA link for iOS.
- Took an MVVM approach to the design, utilizing an observable viewModel with the support of date time helper struct and api service class.
- The view model depends on a BusinessInfoService protocol to allow abstraction, and better testability.
- TimeInfo is chosen to be a class to utilize reference semantics, especially when updating the instances to remove overlaps and combine continuations.
- Used a custom DisclosureGroupStyle to account for the divider and also to customize the chevron as per the FIGMA specs.
- Extended String, Date and Color types to provide some added functionality for ease of use.
- Added unit tests to test the view model and the date time helper, as well as the extended functionality included for Date and String.

## Pending improvements (TODOs):
- Add the capability to fetch and cache the background image if needed. If the image changes, we can update the cache with the new image.
- Create a better error screen that allows reloading data and is visually appealing.
- Add more unit tests to cover the model, data parser, etc.
- Use a logger class to log error events instead of printing directly to console.
- Add launch screen and app icon.
- Futher clean up and organize view into components where possible for better clarity and future reusability.

## Build tools:
Built using Xcode 15.4 and iOS 17.5
