# shopping_list

This repository contains a Flutter project for learning purposes.

The main purpose of this repository is to learn how to make code that can be built for mobile (Android) and desktop (Ubuntu).

The projected steps are:

  1. :heavy_check_mark: Make a simple shopping list app that allows to add and remove items in a list;
  2. :heavy_check_mark: Implement localization for PT_BR and EN_US;
  3. :x: Persist locally on the device the items added and removed from the list;
  4. :x: Build a simple backend API separately, to manage and persist data on a server;
  5. :x: Consume the API;
  6. :x: Implement tests;

As the steps will be completed :x: will be replaced by :heavy_check_mark:

---

[To run on linux](https://flutter.dev/desktop)

---

To run tests with html coverage report: ```flutter test --coverage && genhtml coverage/lcov.info -o coverage/html```

- Note: ```lcov``` must be installed (```sudo apt install lcov```)
