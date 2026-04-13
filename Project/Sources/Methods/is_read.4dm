//%attributes = {"shared":true}
#DECLARE($conversation : cs.Conversation; $user : cs.User) : Boolean

return $conversation.messages.every(Formula($1.value.readBy.includes($user.id)))