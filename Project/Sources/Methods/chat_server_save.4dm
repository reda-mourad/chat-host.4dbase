//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($conversation : Object)->$saveConversation : cs.Conversation

var $ds:=remote_ds()
var $entity : 4D.Entity

$entity:=$ds.Conversation.get($conversation.id) || $ds.Conversation.new()
$entity.ID:=$conversation.id
$entity.data:=$conversation
$entity.save()

return $conversation