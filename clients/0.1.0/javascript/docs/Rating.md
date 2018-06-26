# A15kInteractions.Rating

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | Internally-set UUID.  Used to retrieve and delete ratings, so treat it as somewhat secret. | 
**contentUid** | **String** | The a15k ID of the content being rated. | 
**variantId** | **String** | The variant ID, only needed for generative assessments | [optional] 
**userUid** | **String** | The ID of the user doing the rating, unique in the scope of the reporting app | 
**type** | **String** | The type of rating | [optional] 
**value** | **Number** | The rating value.  Set value is based on the type, e.g. 1.0 is a thumbs up, -1.0 is a thumbs down. | 


<a name="TypeEnum"></a>
## Enum: TypeEnum


* `thumbs` (value: `"thumbs"`)

* `five_star` (value: `"five_star"`)

* `full_range` (value: `"full_range"`)




