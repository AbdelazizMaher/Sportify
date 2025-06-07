# 🏆 Sportify iOS App

A sports information iOS app using the [AllSportsAPI](https://allsportsapi.com), built with Swift, Alamofire, and CoreData. This app allows users to explore sports, view leagues and events, and save their favorite leagues locally — all within an elegant, consistent UI.

## Contributors
- [Abdelaziz Maher](https://www.linkedin.com/in/abdelaziz-maher-9985b2229)
- [Ali Kotb](https://www.linkedin.com/in/alikotb/)

## 📱 Features

### 📂 Main Screen (TabBar)
- **`Sports Tab`**
  - Displays a grid of all available sports `(2 per row in a CollectionView)`
  - Each sport shows a `thumbnail` and `name`
  - Tapping a sport navigates to its leagues

- **`Favorite Leagues Tab`**
  - Displays user-saved favorite leagues using CoreData
  - UI identical to the Leagues ViewController
  - Checks internet connectivity before navigating to league details

### 🏅 Leagues ViewController
- Title: `"Leagues"`
- TableView of leagues for the selected sport
- Each cell displays:
  - Circular league badge
  - League name
- Tapping a league shows its details


### 📖 League Details ViewController
- Title: `"League Details"`
- Option to add league to favorites via top-right button
- Divided into three sections:
  1. **`Upcoming Events`**
     - Horizontal CollectionView: event name, date, time, team images
  2. **`Latest Events`**
     - Vertical CollectionView: match info (teams, scores, date, time, images)
  3. **`Teams`**
     - Horizontal CollectionView: circular team images
     - Tapping an image navigates to Team Details


### 👥 Team Details ViewController
- Displays `key details` about the selected team  
- `Clean`, `elegant`, and `consistent UI`


## 🛠️ Technologies & Libraries
- **`Swift`**
- **`UIKit`**
- **`Alamofire`** — for API networking
- **`CoreData`** — for local data storage
- **`AutoLayout`** — for responsive, consistent UI
- **`AllSportsAPI`**

## 🏗️ Design Patterns
- **`MVP (Model-View-Presenter)`**
  - Clean separation between views `(ViewControllers)`, `presentation logic (Presenters)`, and `data models`
  - Improves `testability` and reduces ViewController `responsibility`

## ✅ Unit Testing
- **`Tests for`**:
  - API response fetching

## 🎁 Bonus Features
- `Onboarding screen` for first-time users
- `Localization` support (English, Arabic)
- `Dark Theme` support (iOS 13+)

## 📌 Notes
- All screens maintain consistent `UI and UX` patterns with precise `AutoLayout constraints`
- `Active internet` connection required for `fetching leagues`, `events`, and `team data`
