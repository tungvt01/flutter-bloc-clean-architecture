## Flutter Todo application
A Flutter To-Do application built using the clean architecture concept, leveraging `flutter_bloc` for state management<br/>

#### First, we need to run following command to generate the necessary files for 
* `objectbox`: generating database scheme
* `mockito`: crate mock test files
* `injectable`: registering dependencies 
```bash
dart run build_runner build --delete-conflicting-outputs
```

#### Run application: <br/>
```bash
flutter run
```

#### Run unit test: <br/>
```bash
flutter test
```

#### Run integration test: <br/>
```bash
flutter test integration_test/*
```
