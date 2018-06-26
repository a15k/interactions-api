# A15kInteractions::PresentationsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_presentation**](PresentationsApi.md#create_presentation) | **POST** /presentations | Indicate that content was presented


# **create_presentation**
> PresentationResponse create_presentation(presentation)

Indicate that content was presented

Called when network content is presented to any end user

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

api_instance = A15kInteractions::PresentationsApi.new

presentation = A15kInteractions::Presentation.new # Presentation | The presentation data


begin
  #Indicate that content was presented
  result = api_instance.create_presentation(presentation)
  p result
rescue A15kInteractions::ApiError => e
  puts "Exception when calling PresentationsApi->create_presentation: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **presentation** | [**Presentation**](Presentation.md)| The presentation data | 

### Return type

[**PresentationResponse**](PresentationResponse.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



