# A15kInteractions.FlagNew

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**contentUid** | **String** | The a15k ID of the content being flagged. | 
**variantId** | **String** | The variant ID, only needed for generative assessments | [optional] 
**userUid** | **String** | The ID of the user doing the flagging, unique in the scope of the reporting app | 
**type** | **String** | The type of flag | 
**explanation** | **String** | The end-user&#39;s explanation of why they added this flag. | [optional] 


<a name="TypeEnum"></a>
## Enum: TypeEnum


* `unspecified` (value: `"unspecified"`)

* `typo` (value: `"typo"`)

* `copyright_violation` (value: `"copyright_violation"`)

* `incorrect` (value: `"incorrect"`)

* `offensive` (value: `"offensive"`)




