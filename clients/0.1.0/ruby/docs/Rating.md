# A15kInteractions::Rating

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | Internally-set UUID.  Used to retrieve and delete ratings, so treat it as somewhat secret. | 
**content_uid** | **String** | The a15k ID of the content being rated. | 
**variant_id** | **String** | The variant ID, only needed for generative assessments | [optional] 
**user_uid** | **String** | The ID of the user doing the rating, unique in the scope of the reporting app | 
**type** | **String** | The type of rating | [optional] 
**value** | **Float** | The rating value.  Set value is based on the type, e.g. 1.0 is a thumbs up, -1.0 is a thumbs down. | 


