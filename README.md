# WallaMarvel

**WallaMarvel** is an iOS app that allows users to explore and search Marvel characters and view details about them, including the comics they appear in.  
The app is developed in **Swift**, following a **Clean Architecture** approach

---

## **Installation**

### **1. Clone the repository**
In the terminal: 
git clone https://github.com/joanmarcs/WallaMarvel

### **2. Pod install**
cd WallaMarvel

**Important: be sure to have at least 1.16.2 CocoaPods version**

pod install


### **3. Run the app**
open WallaMarvel.xcworkspace

run on a simulator or device


## **Architecture**

The project follows Clean Architecture, structuring the code into three main layers:

1. **Data Layer:** Handles API requests and data persistence.
2. **Domain Layer:** Contains the Use Cases and domain entities.
3. **Presentation Layer:** Manages UI logic and user interaction.


## **Modules**

1. **Data:**  APIClient, MarvelRepository, MarvelDataSource
2. **Domain:**  Use Cases, Entities
3. **ListHeroes:**  ListHeroesPresenter, ListHeroesViewController, ListHeroesAdapter
4. **HeroDetail:**  HeroDetailPresenter, HeroDetailViewController, HeroComicsAdapter


