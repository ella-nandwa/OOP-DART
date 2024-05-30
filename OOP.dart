import 'dart:io';

// Interface
abstract class Loanable {
  void checkOut();
  void checkIn();
}

// Base class
class LibraryItem {
  String title;
  String author;

  LibraryItem(this.title, this.author);

  void display() {
    print('Title: $title, Author: $author');
  }
}

// Derived class that implements the interface
class Book extends LibraryItem implements Loanable {
  String isbn;
  bool isCheckedOut = false;

  Book(String title, String author, this.isbn) : super(title, author);

  @override
  void checkOut() {
    if (!isCheckedOut) {
      isCheckedOut = true;
      print('$title has been checked out.');
    } else {
      print('$title is already checked out.');
    }
  }

  @override
  void checkIn() {
    if (isCheckedOut) {
      isCheckedOut = false;
      print('$title has been checked in.');
    } else {
      print('$title was not checked out.');
    }
  }

  @override
  void display() {
    super.display();
    print('ISBN: $isbn');
  }
}

// Derived class that overrides an inherited method
class Magazine extends LibraryItem {
  int issueNumber;

  Magazine(String title, String author, this.issueNumber)
      : super(title, author);

  @override
  void display() {
    super.display();
    print('Issue Number: $issueNumber');
  }
}

// Function to read data from file and create instances
Future<List<Book>> readBooksFromFile(String filename) async {
  List<Book> books = [];
  try {
    final lines = await File(filename).readAsLines();
    for (var line in lines) {
      final parts = line.split(',');
      if (parts.length == 3) {
        books.add(Book(parts[0], parts[1], parts[2]));
      }
    }
  } catch (e) {
    print('Error reading file: $e');
  }
  return books;
}

// Method demonstrating the use of a loop
void displayLibraryItems(List<LibraryItem> items) {
  for (var item in items) {
    item.display();
    print('-' * 20);
  }
}

// Main part of the program
void main() async {
  // Initialize instances from a file
  List<Book> books = await readBooksFromFile('books.txt');

  // Create instances of other library items
  Magazine magazine1 = Magazine('National Geographic', 'Various', 202);
  Magazine magazine2 = Magazine('Time', 'Various', 314);

  // Combine all items into a list
  List<LibraryItem> libraryItems = [...books, magazine1, magazine2];

  // Display all library items
  displayLibraryItems(libraryItems);
}
