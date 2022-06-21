### data layer

contains : repository implementation + models + dataSources classes or services.
example  : auth repository(impl auth repository from the domain layer) + user model (impl user entity)

# explanation

models : they extend the [domain layer] entities and they hold the fromJson conversion 
constructors " and any parsing that is required " 
data sources : remote services and local services implementation (cache + api ) => outputs models
repositories : impl the repositories from the [domain layer]: receives models => outputs entities