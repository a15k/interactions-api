# A15kInteractions.AppsApi

All URIs are relative to *https://localhost/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createApp**](AppsApi.md#createApp) | **POST** /apps | Create a new app
[**deleteApp**](AppsApi.md#deleteApp) | **DELETE** /apps/{id} | Delete an app
[**getApp**](AppsApi.md#getApp) | **GET** /apps/{id} | Get a specific app
[**getApps**](AppsApi.md#getApps) | **GET** /apps | Get all apps matching a query
[**updateApp**](AppsApi.md#updateApp) | **PUT** /apps/{id} | Update an app


<a name="createApp"></a>
# **createApp**
> App createApp(opts)

Create a new app

Create a new app with some values pre-populated; does not take initial values

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_token
var api_token = defaultClient.authentications['api_token'];
api_token.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.AppsApi();

var opts = { 
  'groupId': "groupId_example" // String | ID under which the new app should be grouped (e.g. the UUID) of the app owner.  Can be used to later retrieve all apps in the same group at once.
};
apiInstance.createApp(opts).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **String**| ID under which the new app should be grouped (e.g. the UUID) of the app owner.  Can be used to later retrieve all apps in the same group at once. | [optional] 

### Return type

[**App**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="deleteApp"></a>
# **deleteApp**
> App deleteApp(id)

Delete an app

Delete the specified app

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_token
var api_token = defaultClient.authentications['api_token'];
api_token.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.AppsApi();

var id = "id_example"; // String | ID of the app to delete

apiInstance.deleteApp(id).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

<a name="getApp"></a>
# **getApp**
> App getApp(id)

Get a specific app

Returns all information about a specific app

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_token
var api_token = defaultClient.authentications['api_token'];
api_token.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.AppsApi();

var id = "id_example"; // String | ID of the app

apiInstance.getApp(id).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

<a name="getApps"></a>
# **getApps**
> [App] getApps(opts)

Get all apps matching a query

Get all apps matching a query.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_token
var api_token = defaultClient.authentications['api_token'];
api_token.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.AppsApi();

var opts = { 
  'groupId': "groupId_example" // String | ID under which apps are grouped (e.g. the UUID) of the app owner.If not provided, returns all apps.
};
apiInstance.getApps(opts).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **String**| ID under which apps are grouped (e.g. the UUID) of the app owner.If not provided, returns all apps. | [optional] 

### Return type

[**[App]**](App.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="updateApp"></a>
# **updateApp**
> App updateApp(id, opts)

Update an app

Update an app with the provided values.

### Example
```javascript
var A15kInteractions = require('A15kInteractionsClient');
var defaultClient = A15kInteractions.ApiClient.instance;

// Configure API key authorization: api_token
var api_token = defaultClient.authentications['api_token'];
api_token.apiKey = 'YOUR API KEY';
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.apiKeyPrefix = 'Token';

var apiInstance = new A15kInteractions.AppsApi();

var id = "id_example"; // String | ID of the app

var opts = { 
  'app': new A15kInteractions.AppUpdate() // AppUpdate | The app data
};
apiInstance.updateApp(id, opts).then(function(data) {
  console.log('API called successfully. Returned data: ' + data);
}, function(error) {
  console.error(error);
});

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

