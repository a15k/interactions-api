# A15kInteractions.FlagsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFlag**](FlagsApi.md#createFlag) | **POST** /flags | Flag some content
[**deleteFlag**](FlagsApi.md#deleteFlag) | **DELETE** /flags/{id} | Delete a flag
[**getFlag**](FlagsApi.md#getFlag) | **GET** /flags/{id} | Retrieve a flag
[**updateFlag**](FlagsApi.md#updateFlag) | **PUT** /flags | Update a flag


<a name="createFlag"></a>
# **createFlag**
> Flag createFlag(flag)

Flag some content

Adds a flag to some content for some user in some app.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.FlagsApi();

var flag = new A15kInteractions.FlagNew(); // FlagNew | The flag data

apiInstance.createFlag(flag).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

<a name="deleteFlag"></a>
# **deleteFlag**
> Flag deleteFlag(id)

Delete a flag

Delete a flag.  Anyone with the flag ID (very hard to guess) can delete it.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.FlagsApi();

var id = "id_example"; // String | ID of the flag to delete

apiInstance.deleteFlag(id).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the flag to delete | 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="getFlag"></a>
# **getFlag**
> Flag getFlag(id)

Retrieve a flag

Retrieve a flag.  Anyone with the flag ID (very hard to guess) can retrieve it.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.FlagsApi();

var id = "id_example"; // String | ID of the flag to retrieve

apiInstance.getFlag(id).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the flag to retrieve | 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="updateFlag"></a>
# **updateFlag**
> Flag updateFlag(id, opts)

Update a flag

Update a flag with the provided values.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_id
var api_id = defaultClient.authentications['api_id'];
api_id.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_id.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.FlagsApi();

var id = "id_example"; // String | ID of the flag

var opts = { 
  'flag': new A15kInteractions.FlagUpdate() // FlagUpdate | The flag data
};
apiInstance.updateFlag(id, opts).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**String**](.md)| ID of the flag | 
 **flag** | [**FlagUpdate**](FlagUpdate.md)| The flag data | [optional] 

### Return type

[**Flag**](Flag.md)

### Authorization

[api_id](../README.md#api_id)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

