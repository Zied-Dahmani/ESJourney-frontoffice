<h1 align="center"> ESJourney </h1> <br>
<p align="center">
  <a href="https://github.com/ZiedDaedly/ESJourney-frontoffice">
       <img alt="ESJourney" title="ESJourney" src="https://raw.githubusercontent.com/ZiedDaedly/ESJourney-frontoffice/main/assets/images/app_logo.png" width="150">
  </a>
</p>

<p align="center">
  A mobile app that gamifies the university journey at  <a href="https://esprit.tn/" target="_blank">ESPRIT</a>! 



<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Introduction](#introduction)
- [App structure](#structure)
- [Features](#features)
- [Build Process](#build-process)


<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction


ESJourney transforms your university journey into an exciting adventure. Explore a virtual campus, complete challenges, and earn rewards as you excel academically, engage in activities, and grow personally. Connect with peers, form study groups, and stay updated with important announcements.



## Structure
### Architecture
ESJourney is developed using a **clean architecutre.** , with a focus on separation of concerns and maintainability. The clean architecture provides a clear structure and helps to keep the codebase organized and modular.

The application follows the principles of clean architecture by dividing the codebase into distinct layers, each with its own responsibilities and dependencies. These layers include:

* **Presentation Layer** : This layer handles the user interface components, such as activities, fragments, and views. It is responsible for displaying data to the user and capturing user interactions. The presentation layer communicates with the other layers through interfaces or abstractions.

* **Domain Layer** : The domain layer contains the core business logic of the application. It defines the use cases and business rules that govern the behavior of the application. This layer is independent of any framework or technology-specific implementation details.

* **Data Layer** : The data layer is responsible for managing data access and storage. It includes repositories, data sources, and network clients. The data layer abstracts the details of data retrieval and storage, allowing the domain layer to work with data through interfaces and models.

### BLoC
In addition to the clean architecture, ESJourney utilizes the BLoC (Business Logic Component) state management approach in Flutter for efficient and reactive application development. For more detailed information on BLoC and how it's implemented in ESJourney, you can refer to the official BLoC library documentation [here](https://bloclibrary.dev/#/gettingstarted).

### Technologies and Tools Used

- [Flutter](https://docs.flutter.dev)
- [NodeJS](https://nodejs.org/en/docs)
- [MongoDB](https://www.mongodb.com/docs)
- [Unity](https://docs.unity.com/)
- [Firebase](https://firebase.google.com/docs)
- [Ktor](https://ktor.io/docs/welcome.html)
- [Ganache](https://trufflesuite.com/docs/ganache)
- [ARKit](https://developer.apple.com/documentation/arkit)


## Features

* Access a wide range of courses offered at ESPRIT and learn by playing online/offline games.
* Engage in interactive challenges and compete with fellow students to climb the leaderboard.
* Explore internship opportunities and apply for positions relevant to your field of study.
* Stay updated on upcoming events, workshops, and seminars happening at ESPRIT and join them via online meeting.
* Explore a diverse range of student clubs and find the perfect match for your interests and passions.

<p align="center">
  <img src="https://i.imgur.com/pLGuRtD.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://i.imgur.com/rKwm2Rr.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://i.imgur.com/MHOrBsM.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 
</p>
<p align="center">
  <img src="https://i.imgur.com/lLMbuez.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://i.imgur.com/gL779ta.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
 
</p>





## Build Process

- Follow the [Flutter Guide](https://docs.flutter.dev/) for getting started building a project.
- Clone or download the repo 

```{r klippy, echo=FALSE, include=TRUE}
git clone https://github.com/ZiedDaedly/ESJourney-frontoffice

```
- Get dependencies

```{r klippy, echo=FALSE, include=TRUE}
flutter pub get

```



