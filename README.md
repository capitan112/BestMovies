# 📱 BestMovies – Top Rated Movies App (Test Project)

A modular iOS application built with **MVVM + Clean Architecture**, designed as a coding exercise.  
The app fetches and displays a list of top-rated movies from The Movie Database (TMDB) API, featuring:

- Search functionality  
- Empty state handling  
- Basic error management  

---

## 🚀 Features

- ✅ Top Rated Movies from TMDB API  
- 🔍 Movie Search by Title  
- 📄 Movie Overview and Rating  
- 📉 Empty state with **"No results"** message  
- 🔁 Retry button on network error  
- 📱 Fully programmatic UI with Auto Layout  
- 🧱 Modular and testable architecture  
- 🧪 Unit & UI Tests with >80% coverage  
- 🧠 No singletons, no storyboards, no force unwraps  

---

## 🧱 Architecture

Based on **MVVM + Clean Architecture** with clearly separated layers:

- **Presentation** – `ViewController` + `ViewModel`  
- **Domain** – `UseCases` + `Entities`  
- **Data** – `Repositories` + `Mappers`  
- **Network** – `NetworkClient` using `URLSession`  

---

## 🧪 Tests

- ✅ Unit tests per module: `ViewModel`, `UseCase`, `Repository`, `Mapper`  
- ✅ UI tests: Search, Empty Results, Retry on Error  
- ✅ 80–100% code coverage  
- ✅ `AppError` tested for `Equatable` & `LocalizedError`  

---

## 🛠 Dependencies

- [`SDWebImage`](https://github.com/SDWebImage/SDWebImage) – for image loading and caching  
- Built with **Swift 5.9** and **Xcode 15+**

---

## 🧪 Run Tests & View Coverage

1. Go to **Product** → **Scheme** → **Edit Scheme...**  
2. Enable ✅ **Gather coverage data** under the **Test** tab  
3. Run tests: `⌘ + U`  
4. Open **Report Navigator**: `⌘ + 9` → **Coverage** tab  

---

## 📸 Screenshots (Optional)

_Add screenshots here to showcase list, empty state, and retry UI._

---
