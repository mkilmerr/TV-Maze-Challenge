 🎥 TV Maze App 

[TV Maze API](https://www.tvmaze.com/api)

## 🍭 Features 
* 🔎 **Search TV Shows**
* 🧔 **Search People**
* ❤️ **Save TV Shows in Local Storage ( Swift Data )**
* 🔐 **Biometric Authentication**
* 🔦 **Dark/Light Mode**

## 🔐📱 Biometric Authentication in Simulator

Enable Face ID in Simulator: 
* Simulator
* Features
* Face ID
* Enrolled
* Allow permissions
* Close and reopen the simulator
* Matching face to allow
* Non-Matching to deny

## 📁 Project Structure

```
TVMaze/
├── Data/
│   ├── DataSource/
│   ├── Endpoint/
│   ├── LocalStorage/
│   └── Repository/
│       ├── FetchPeopleRepository
│       ├── SearchTVShowsRepository
│       ├── TVShowEpisodesRepository
│       └── TVShowsRepository
├── Domain/
│   ├── Biometric/
│   ├── Model/
│   ├── Repository/
│   │   ├── FetchPeopleRepositoryProtocol
│   │   ├── SearchTVShowsRepositoryProtocol
│   │   ├── TVShowEpisodesRepositoryProtocol
│   │   └── TVShowsRepositoryProtocol
│   └── UseCase/
│       ├── FetchPeopleUseCase
│       ├── FetchTVShowEpisodesUseCase
│       ├── FetchTVShowsUseCase
│       └── SearchTVShowsUseCase
├── Presentation/
│   ├── Biometric/
│   │   └── BiometricAuthentication/
│   ├── Episode/
│   ├── People/
│   │   └── List/
│   ├── TVShowDetail/
│   └── TVShowsList/
└── Utils/
    ├── Pill
    ├── RemoteImage
    ├── SafariWebView
    ├── String+RemoveHTML
    └── ViewDidLoadModifier

TVMazeTests/
├── Data/
│   └── Repository/
├── Domain/
│   └── UseCase/
└── Presentation/
    ├── BiometricAuthentication/
    ├── People/
    └── TVShowDetail/

```

## 🧰 Architecture

The project follows Clean Architecture principles with the following layers:

### Data Layer
- Implements concrete repositories
- Handles data sources (API, local storage)
- Converts DTOs to domain models

### Domain Layer
- Contains business logic
- Defines repository protocols
- Implements use cases
- Contains model entities

### Presentation Layer
- Implements MVVM pattern
- Contains ViewModels and Views
- Handles UI logic and state

### Utils
- Contains reusable components
- Helper extensions and modifiers

</details>


## 📺 Screens

#### Face ID
<img src="https://github.com/user-attachments/assets/1690721f-877f-4db9-a693-8914d582b992" width="300"/>
<img src="https://github.com/user-attachments/assets/f03d435d-c5cc-4af1-90b0-67290657462a" width="300"/>
<img src="https://github.com/user-attachments/assets/413164ec-e21c-4940-9d2f-cb3d0c75e7a5" width="300"/>

#### Search TV Show

<img src="https://github.com/user-attachments/assets/ec134490-db9f-45f0-83dc-bac2a66a0518" width="300"/>
<img src="https://github.com/user-attachments/assets/6fae826e-06c8-4d70-83f8-1ba825d32775" width="300"/>
<img src="https://github.com/user-attachments/assets/0a6ea439-1ffc-4ebb-b729-626fbd843ddd" width="300"/>
<img src="https://github.com/user-attachments/assets/e45d6ee8-5a36-4b3b-9e5e-2a46f774432b" width="300"/>

#### Search People
<img src="https://github.com/user-attachments/assets/eac71a56-7c73-4e1b-a535-b967c12db277" width="300"/>
<img src="https://github.com/user-attachments/assets/bb0cfe46-a7a1-4d6a-bf7a-bdade76087db" width="300"/>
<img src="https://github.com/user-attachments/assets/d8377ab2-5fde-4fb0-8701-9e632e443af4" width="300"/>
<img src="https://github.com/user-attachments/assets/e7b9d841-1658-46f3-a9ff-55b2718767dd" width="300"/>


#### Favorite TV Shows

<img src="https://github.com/user-attachments/assets/8861f599-41e7-4063-8869-7023312ebe2c" width="300"/>
<img src="https://github.com/user-attachments/assets/0c0e68a6-4a94-456e-a969-d541ea1ca55b" width="300"/>
