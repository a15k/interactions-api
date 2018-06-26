# A15kInteractions.RatingsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createRating**](RatingsApi.md#createRating) | **POST** /ratings | Rate some content
[**deleteRating**](RatingsApi.md#deleteRating) | **DELETE** /ratings/{id} | Delete a rating
[**getRating**](RatingsApi.md#getRating) | **GET** /ratings/{id} | Retrieve a rating


<a name="createRating"></a>
# **createRating**
> Rating createRating(rating)

Rate some content

Rates some content for some user in some app.  New ratings replace old ratings.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.RatingsApi();

var rating = new A15kInteractions.RatingNew(); // RatingNew | The rating data

apiInstance.createRating(rating).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

<a name="deleteRating"></a>
# **deleteRating**
> Flag deleteRating(id)

Delete a rating

Delete a rating.  Anyone with the rating ID (very hard to guess) can delete it.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.RatingsApi();

var id = "id_example"; // String | ID of the rating to delete

apiInstance.deleteRating(id).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

<a name="getRating"></a>
# **getRating**
> Rating getRating(id)

Retrieve a rating

Retrieve a rating.  Anyone with the rating ID (very hard to guess) can retrieve it.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.RatingsApi();

var id = "id_example"; // String | ID of the rating to retrieve

apiInstance.getRating(id).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

