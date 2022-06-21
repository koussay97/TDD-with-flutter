### domain layer
completely independent from other layers 
=> it is based on abstractions.

contains : use cases + entities + repositories.
example  : use_case "Auth:: abstract interphase", entity "User", repository "login + register... :: abstract classes"

# explanation

- use_cases are abstract contracts that are function that are feature specific , they implement the repository class (because repository is an interface for all of the use cases)
- entities are abstract classes that define our feature specific entity
  ( user entity: contains attributes and constructor )
- repositories define an abstract contract for the use case (using dependency inversion ),
  these abstract contracts serve as an object interface to be extended in the repository folder
  that exists in the data layer, which means it is the bridge between the [data layer] and the [domain layer]
  ( dart does not use interfaces therefore we write it as an abstract class )  
