## Movie Finder

This is a movie finder application using [OMDB API](http://omdbapi.com) for backend.

- Design and implement Splash screen
  - [x] Check internet connectivity
  - [x] Get remote text by using Firebase Remote Config
- Design and implement Movie Search screen
  - [x] Movie search implemented
- Design and implement Movie Detail screen
  - [x] Showing movie details implemented
  - [x] Logging firebase event

**I've implemented remote notifications part with `Firebase Messaging`. However, I don't have any available Apple developer account currently. Because of that I couldn't send remote notification so I couldn't try whether remote notifications are working or not.**

### High Level Overview of Architecture

![High level overview](./Architecture/Modules.png)

#### Domain

The `Domain` is basically what is your App about and what it can do (Entities, UseCase etc.) It does not depend on UIKit or any persistence framework, and it doesn't have implementations apart from entities

#### Platform

The `Platform` is a concrete implementation of the `Domain` in a specific platform like iOS. It does hide all implementation details. For example Database implementation whether it is CoreData, Realm, SQLite etc.

In this project we have only implemented networking layer for communication with our backend server.

#### Application

`Application` is responsible for delivering information to the user and handling user input. It can be implemented with any delivery pattern e.g (MVVM, MVC, MVP). This is the place for your UIViews and `UIViewController`s. As you will see from the project, `ViewControllers` are completely independent of the Platform. The only responsibility of a view controller is to "bind" the UI to the `Domain` to make things happen. In the current project, `Application` is implemented with the MVVM pattern with usage of `RxSwift`.

## Installation

This project uses 3rd party dependencies. In order to install 3rd party dependencies run the command below

`pod install`
