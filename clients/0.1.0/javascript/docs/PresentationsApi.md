# A15kInteractions.PresentationsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPresentation**](PresentationsApi.md#createPresentation) | **POST** /presentations | Indicate that content was presented


<a name="createPresentation"></a>
# **createPresentation**
> PresentationResponse createPresentation(presentation)

Indicate that content was presented

Called when network content is presented to any end user

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.PresentationsApi();

var presentation = new A15kInteractions.Presentation(); // Presentation | The presentation data

apiInstance.createPresentation(presentation).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

