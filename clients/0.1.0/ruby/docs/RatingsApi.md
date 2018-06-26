# A15kInteractions::RatingsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_rating**](RatingsApi.md#create_rating) | **POST** /ratings | Rate some content
[**delete_rating**](RatingsApi.md#delete_rating) | **DELETE** /ratings/{id} | Delete a rating
[**get_rating**](RatingsApi.md#get_rating) | **GET** /ratings/{id} | Retrieve a rating


# **create_rating**
> Rating create_rating(rating)

Rate some content

Rates some content for some user in some app.  New ratings replace old ratings.

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

api_instance = A15kInteractions::RatingsApi.new

rating = A15kInteractions::RatingNew.new # RatingNew | The rating data


begin
  #Rate some content
  result = api_instance.create_rating(rating)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling RatingsApi->create_rating: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **rating** | [**RatingNew**](RatingNew.md)| The rating data | 

### Return type

[**Rating**](Rating.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **delete_rating**
> Flag delete_rating(id)

Delete a rating

Delete a rating.  Anyone with the rating ID (very hard to guess) can delete it.

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

api_instance = A15kInteractions::RatingsApi.new

id = "id_example" # String | ID of the rating to delete


begin
  #Delete a rating
  result = api_instance.delete_rating(id)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling RatingsApi->delete_rating: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the rating to delete | 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_rating**
> Rating get_rating(id)

Retrieve a rating

Retrieve a rating.  Anyone with the rating ID (very hard to guess) can retrieve it.

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

api_instance = A15kInteractions::RatingsApi.new

id = "id_example" # String | ID of the rating to retrieve


begin
  #Retrieve a rating
  result = api_instance.get_rating(id)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling RatingsApi->get_rating: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the rating to retrieve | 

### Return type

[**Rating**](Rating.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



