# Weather App

Fetch weather Api to display current weather & weather forecasts to users.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


## Version

1.0

## Prerequisites

- Xcode 15.4 or later
- iOS 14.0 or later
- macOS 14.5 or later

## 1. Dependencies

We will be building this app using Xcode 15.4 with Swift 5.0. This app also consumes the [Weather API](https://www.weatherapi.com) hosted on [www.weatherapi.com](https://www.weatherapi.com) to fetch real-time weather/weather forecasts of a city.

- Xcode 15.4
- Swift 5.0


## 2. Library Dependencies

- RxSwift (Reactive library in Swift [Installation instructions](https://github.com/ReactiveX/RxSwift#installation).)
- RxCocoa (Reactive library for UIKit in Swift [Installation instructions](https://github.com/ReactiveX/RxSwift#installation).)
- RxGesture (Reactive Gesture library for UIKit in Swift [Installation instructions](https://github.com/RxSwiftCommunity/RxGesture#installation).)
- Alamofire (Network library for API calls in Swift [Installation instructions](https://github.com/Alamofire/Alamofire#installation).)
- SDWebImage (Async image downloader library with cache support in Swift [Installation instructions](https://github.com/SDWebImage/SDWebImage#installation).)
- SwiftLoader (Activity indicator library in Swift [Installation instructions](https://github.com/leoru/SwiftLoader#install).)

## 3. Written in Swift

This sample is written in Swift.


## Tools

- [Swift Package Manager](https://swift.org/package-manager/) 
- `Swift Package Manager` is a dependency manager for Swift and Objective-C Cocoa projects. It has over 33 thousand libraries and is used in over 2.2 million apps. Swift Package Manager can help you scale your projects elegantly.

## Design Patterns

- ### MVVM

Model-View-ViewModel (MVVM) is one of the building blocks of Cocoa and is undoubtedly the most-used design pattern of all. It classifies objects according to their general role in your application and encourages clean separation of code based on role.

![minio_SWIFT1](https://koenig-media.raywenderlich.com/uploads/2019/12/MVVM-Diagram.png)

- ### Facade

The Facade design pattern provides a single interface to a complex subsystem. Instead of exposing the user to a set of classes and their APIs, you only expose one simple unified API.

![minio_SWIFT1](https://koenig-media.raywenderlich.com/uploads/2013/07/facade2.png)

- ### Decorator

The Decorator pattern dynamically adds behaviors and responsibilities to an object without modifying its code. It’s an alternative to subclassing where you modify a class’s behavior by wrapping it with another object.

In Swift, there are two very common implementations of this pattern: Extensions and Delegation.

## Features

- MVVM pattern used
- Modular enough to add others calls from [Weather](https://www.weatherapi.com) API.

## Installation

Cloning or downloading the repository

- Go to working directory
- Open weather-forecast-ios.xcodeproj
- Use command + B or Product -> Build to build the project
- Press run icon in Xcode or command + R to run the project on Simulator

## Step to run the project from command-line

- Make sure command-line tools of Xcode is installed
- Go to working Directory
- xcodebuild -scheme weather-forecast-ios build -allowProvisioningUpdates

## Step to static code coverage

- Open weather-forecast-ios.xcodeproj
- Use Command+Shift+B or Product+Analyze to analyze the project


## To Do

### CI/CD

- [Jenkins](http://jenkins.io)
- [Azure DevOps](https://azure.microsoft.com/en-in/services/devops/#DevOps)
- [TestFlight](https://developer.apple.com/testflight/)
- [fastlane](https://fastlane.tools)
- [Xcode Server](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/index.html)

### Crash Reporting

- [AppCenter](https://appcenter.ms/)

## Code Coverage

- [SonarQube 7.2.1](https://github.com/Jintin/Swimat) - SonarQube provides the capability to not only show health of an application but also to highlight issues newly introduced. With a Quality Gate in place, you can fix the leak and therefore improve code quality systematically.

## License

Distributed under the MIT license. See `LICENSE` for more information.

[LICENSE](LICENSE)

[swift-image]: https://img.shields.io/badge/swift-5.0-orange
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
