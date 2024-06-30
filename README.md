
# Flashcards Flutter Application

## Overview

The Flashcards Flutter Application is a robust and intuitive mobile application designed to help users create, manage, and quiz themselves using decks of flashcards. The application supports deck creation, flashcard management, and quiz functionalities with persistent data storage, ensuring a seamless and effective learning experience.

## Features

- **Deck Management**: Easily create, edit, and delete decks of flashcards.
- **Flashcard Management**: Create, edit, sort, and delete flashcards within any deck.
- **Data Persistence**: Automatically save all decks and flashcards locally to maintain data across sessions.
- **Quizzes**: Conduct quizzes with shuffled flashcards from any selected deck, track progress, and review answers.
- **Responsive Design**: Adaptive UI for various screen sizes, providing an optimal user experience on all devices.

## Screenshots

![Storyboard](assets/storyboard.png)

## Behavioral Specifications

### Deck List Page
- Displays a scrollable list of decks, identified by their titles.
- Shows the number of cards in each deck.
- Tapping on a deck navigates to its card list.
- Includes options to create a new deck, edit or delete existing decks, and load decks from a JSON file.

### Deck Editor
- Allows editing the selected deck’s title.
- Optionally, decks can be deleted from this screen.

### Card List
- Displays a scrollable list of cards in a deck, identified by their questions.
- Cards can be sorted alphabetically or by creation date.
- Tapping on a card opens the card editor.
- Includes a button to start a quiz with the deck’s cards.

### Card Editor
- Displays and allows editing of a card’s question and answer fields.
- Provides an option to delete the card.

### Quiz
- Shows flashcards from a selected deck in a randomized order.
- Allows navigation through the flashcards, with options to view questions and peek at answers.
- Displays the progress of the quiz, including the number of cards viewed and answers peeked.

### Responsiveness
- Adapts UI based on screen size.
- Displays deck and flashcard lists separately on smaller screens and together on larger screens.
- Quiz page prioritizes flashcard display on different screen sizes.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) SDK
- [Dart](https://dart.dev/get-dart) SDK

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Mahmood-Anaam/Flashcards-Flutter.git
   cd Flashcards-Flutter
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

## Usage

### Deck Management

- **Create a Deck**: Navigate to the Deck List page and click on the "Add Deck" button. Enter a title for the new deck and save.
- **Edit a Deck**: Tap on a deck from the Deck List page to open the Deck Editor. Modify the title and save changes.
- **Delete a Deck**: Use the delete option in the Deck Editor or from the Deck List page.

### Flashcard Management

- **Add Flashcards**: Open a deck to view its flashcards and use the "Add Card" button to create a new flashcard.
- **Edit Flashcards**: Tap on a flashcard to open the Card Editor. Modify the question and answer fields and save changes.
- **Sort Flashcards**: Flashcards can be sorted alphabetically or by creation date.

### Running Quizzes

- **Start a Quiz**: Open a deck and navigate to the quiz page. Flashcards will be shuffled, and you can move through them, viewing questions and peeking at answers.
- **Track Progress**: The quiz interface shows the number of cards viewed and the number of answers peeked.

## Implementation Details

### External Packages

The app leverages several external packages to enhance functionality:
- `provider`: State management.
- `collection`: Data structure operations.
- `sqflite`: SQLite database management.
- `path_provider`: File system path management.
- `path`: Path operations.

### Database

A local SQLite database, managed by the `sqflite` package, stores all deck and flashcard data. This ensures data persistence across application restarts.

### Navigation

The `Navigator` widget in Flutter handles navigation between different pages of the app, ensuring smooth transitions and efficient state management.

### JSON Initialization

A starter set of decks and flashcards is provided in a JSON file (`assets/flashcards.json`). This file is parsed and its data is inserted into the database when the associated menu item or button is selected.

## APK Deployment

The application is available for download in APK format for Android devices at the following link: [Download APK](https://drive.google.com/drive/folders/1imrRORnlZpuvd29ZpnQpbvulj7tceJSu)

## Contribution

We welcome contributions! Please fork the repository and submit pull requests with clear descriptions of your changes.

