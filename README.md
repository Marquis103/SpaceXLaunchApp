# SpaceXLaunchApp

Code challenge showing a `UITableView` of Upcoming Space X launches, with ancillary metadata.

## Setup
- XCode 12.3+
- Swift 5.0

## Design Rationale
I completed this code challenge without the use of 3rd party dependencies.  I do this explicitly for code challenges because it forces me to think about not only what exactly I'm trying to do, but also makes me sharper in attempting to using the Apple SDK directly.

I did not add any custom animations, I wanted to get things functional and presentable in a timely manner.  I used a card like design for the launch `UITableViewCell`s and a standard `UILabel` fired from a `Timer` for the countdown view.
