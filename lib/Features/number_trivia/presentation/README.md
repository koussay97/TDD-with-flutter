### presentation layer

contains : widgets/screens + presentation logic holders.
example  : such as custom widgets ( or screens ) and view-models (could be change notifier classes or blocs)

# explanation

this folder must contain all of the widgets and business logic related to the feature in question.
For instance lets assume we have a login feature: 
this folder will contain the login widgets and screens also the state management paradigm we use,
related to login only,

login view-model will only communicate with the login-use-case class that is declared in the 
[domain layer]