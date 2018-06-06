# A15kInteractions::Flag

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | Internally-set UUID.  Used to retrieve and delete flags, so treat it as somewhat secret. | 
**content_uid** | **String** | The a15k ID of the content being flagged. | 
**variant_id** | **String** | The variant ID, only needed for generative assessments | [optional] 
**user_uid** | **String** | The ID of the user doing the flagging, unique in the scope of the reporting app | 
**type** | **String** | The type of flag | 
**explanation** | **String** | The end-user&#39;s explanation of why they added this flag. | [optional] 


