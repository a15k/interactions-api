# A15kInteractions::AppsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_app**](AppsApi.md#create_app) | **POST** /apps | Create a new app
[**delete_app**](AppsApi.md#delete_app) | **DELETE** /apps/{id} | Delete an app
[**get_app**](AppsApi.md#get_app) | **GET** /apps/{id} | Get a specific app
[**get_apps**](AppsApi.md#get_apps) | **GET** /apps | Get all apps matching a query
[**update_app**](AppsApi.md#update_app) | **PUT** /apps/{id} | Update an app


# **create_app**
> App create_app(opts)

Create a new app

Create a new app with some values pre-populated; does not take initial values

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::AppsApi.new

opts = { 
  group_id: "group_id_example" # String | ID under which the new app should be grouped (e.g. the UUID) of the app owner.  Can be used to later retrieve all apps in the same group at once.
}

begin
  #Create a new app
  result = api_instance.create_app(opts)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling AppsApi->create_app: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **group_id** | **String**| ID under which the new app should be grouped (e.g. the UUID) of the app owner.  Can be used to later retrieve all apps in the same group at once. | [optional] 

### Return type

[**App**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **delete_app**
> App delete_app(id)

Delete an app

Delete the specified app

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::AppsApi.new

id = "id_example" # String | ID of the app to delete


begin
  #Delete an app
  result = api_instance.delete_app(id)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling AppsApi->delete_app: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the app to delete | 

### Return type

[**App**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_app**
> App get_app(id)

Get a specific app

Returns all information about a specific app

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::AppsApi.new

id = "id_example" # String | ID of the app


begin
  #Get a specific app
  result = api_instance.get_app(id)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling AppsApi->get_app: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the app | 

### Return type

[**App**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_apps**
> Array&lt;App&gt; get_apps(opts)

Get all apps matching a query

Get all apps matching a query.

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::AppsApi.new

opts = { 
  group_id: "group_id_example" # String | ID under which apps are grouped (e.g. the UUID) of the app owner.If not provided, returns all apps.
}

begin
  #Get all apps matching a query
  result = api_instance.get_apps(opts)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling AppsApi->get_apps: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **group_id** | **String**| ID under which apps are grouped (e.g. the UUID) of the app owner.If not provided, returns all apps. | [optional] 

### Return type

[**Array&lt;App&gt;**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_app**
> App update_app(id, opts)

Update an app

Update an app with the provided values.

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::AppsApi.new

id = "id_example" # String | ID of the app

opts = { 
  app: A15kInteractions::AppUpdate.new # AppUpdate | The app data
}

begin
  #Update an app
  result = api_instance.update_app(id, opts)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling AppsApi->update_app: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the app | 
 **app** | [**AppUpdate**](AppUpdate.md)| The app data | [optional] 

### Return type

[**App**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



