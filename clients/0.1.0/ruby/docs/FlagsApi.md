# A15kInteractions::FlagsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_flag**](FlagsApi.md#create_flag) | **POST** /flags | Flag some content
[**delete_flag**](FlagsApi.md#delete_flag) | **DELETE** /flags/{id} | Delete a flag
[**get_flag**](FlagsApi.md#get_flag) | **GET** /flags/{id} | Retrieve a flag
[**update_flag**](FlagsApi.md#update_flag) | **PUT** /flags | Update a flag


# **create_flag**
> Flag create_flag(flag)

Flag some content

Adds a flag to some content for some user in some app.

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_id
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::FlagsApi.new

flag = A15kInteractions::FlagNew.new # FlagNew | The flag data


begin
  #Flag some content
  result = api_instance.create_flag(flag)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling FlagsApi->create_flag: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **flag** | [**FlagNew**](FlagNew.md)| The flag data | 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **delete_flag**
> Flag delete_flag(id)

Delete a flag

Delete a flag.  Anyone with the flag ID (very hard to guess) can delete it.

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_id
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::FlagsApi.new

id = "id_example" # String | ID of the flag to delete


begin
  #Delete a flag
  result = api_instance.delete_flag(id)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling FlagsApi->delete_flag: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| ID of the flag to delete | 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_flag**
> Flag get_flag(id)

Retrieve a flag

Retrieve a flag.  Anyone with the flag ID (very hard to guess) can retrieve it.

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_id
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::FlagsApi.new

id = "id_example" # String | ID of the flag to retrieve


begin
  #Retrieve a flag
  result = api_instance.get_flag(id)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling FlagsApi->get_flag: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| ID of the flag to retrieve | 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_flag**
> Flag update_flag(id, opts)

Update a flag

Update a flag with the provided values.

### Example
```ruby
# load the gem
require 'a15k_interactions_api'
# setup authorization
A15kInteractions.configure do |config|
  # Configure API key authorization: api_id
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kInteractions::FlagsApi.new

id = "id_example" # String | ID of the flag

opts = { 
  flag: A15kInteractions::Flag.new # Flag | The flag data
}

begin
  #Update a flag
  result = api_instance.update_flag(id, opts)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling FlagsApi->update_flag: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| ID of the flag | 
 **flag** | [**Flag**](Flag.md)| The flag data | [optional] 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



