//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($users : Collection; $subject : Text) : cs.Conversation

var $ds:=remote_ds()
var $entity : 4D.Entity
var $queryParts : Collection
var $conversation : cs.Conversation
var $i : Integer

If ($users.length=2)
	
	$queryParts:=$users.map(Formula(Replace string("data.users[] = '$'"; "$"; String($1.value.id))))
	$queryParts.push("data.users.length = "+String($users.length))
	$entity:=$ds.Conversation.query($queryParts.join(" AND ")).first()
	
	If ($entity=Null)
		return chat_server_save(cs.Conversation.new($users; $subject))
	End if 
	
	return $entity.data
	
End if 

return chat_server_save(cs.Conversation.new($users; $subject))