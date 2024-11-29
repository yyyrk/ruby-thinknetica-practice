# Ruby Metaprogramming Project

This repository showcases a practical Ruby project focused on metaprogramming concepts. The project simulates a train management system, integrating advanced features like custom accessors, validations, and modular design.

## Overview

The project contains various classes and modules that represent trains, wagons, stations, routes, and their interactions. Key Ruby techniques like dynamic method creation, mixins, and type enforcement are implemented to demonstrate metaprogramming and OOP principles.

## Features

- **Train Management**: Classes for `Train`, `PassengerTrain`, and `CargoTrain`.
- **Wagon Management**: Classes for `PassengerWagon` and `CargoWagon` with dynamic attributes.
- **Station Management**: The `Station` class tracks and filters trains.
- **Route Definition**: The `Route` class handles the journey path for trains.
- **Custom Accessors**:
  - `attr_accessor_with_history`: Keeps a history of attribute values.
  - `strong_attr_accessor`: Enforces type checking on attributes.
- **Validation**:
  - Ensures attribute presence, format, and type correctness.
  - Dynamically integrates validations into classes.

## Project Structure

project/ ├── accessors.rb # Custom accessors module ├── validations.rb # Validation module ├── manufactures.rb # Manufacturer details module ├── instance_counter.rb # Module for class instance tracking ├── train.rb # Train base class ├── passenger_train.rb # PassengerTrain subclass ├── cargo_train.rb # CargoTrain subclass ├── wagon.rb # Wagon base class ├── passenger_wagon.rb # PassengerWagon subclass ├── cargo_wagon.rb # CargoWagon subclass ├── station.rb # Station class ├── route.rb # Route class ├── main.rb # Entry point for the application └── README.md # Documentation


## Key Modules and Classes

### `Accessors`
- **Methods**:
  - `attr_accessor_with_history`: Tracks historical changes to attributes.
  - `strong_attr_accessor`: Restricts attributes to specific data types.
  
### `Validation`
- Provides:
  - **Presence Validation**: Ensures attributes are not `nil`.
  - **Type Validation**: Verifies attributes match specified data types.
  - **Format Validation**: Validates attributes against regex patterns.

### `Train`
Manages train attributes and operations, such as:
- Assigning and navigating routes.
- Connecting and disconnecting wagons.
- Speed control.

### `Wagon`
A base class for wagons, with features to dynamically manage attributes and enforce rules.

### `Station`
Tracks trains at a station and offers methods to filter trains by type.

### `Route`
Defines the path trains follow, with functionality to add and remove stations.

## Running the Application

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/ruby-metaprogramming.git
   cd ruby-metaprogramming
```

2. Run the application:

   ```bash
ruby main.rb
```

## Examples
Using attr_accessor_with_history

wagon = Wagon.new('001', :cargo, 100)
wagon.number = '002'
wagon.number = '003'
puts wagon.number_history # Output: ["001", "002"]

## Validating Attributes

```ruby

train = Train.new(nil) # Raises an error: "Attribute 'number' can't be nil"
Enforcing Type with strong_attr_accessor
```
```ruby
wagon.amount = 'not_a_number' # Raises an error: "Expected Integer, got String"
```

Contributing
Contributions are welcome! If you find any bugs or want to enhance functionality, feel free to open an issue or submit a pull request.

License
This project is licensed under the MIT License.
------

Developed with ❤️ by Andrew Yurik.
