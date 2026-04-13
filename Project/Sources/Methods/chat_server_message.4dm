//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($user : cs.User; $conversation : cs.Conversation; $text : Text) : cs.Conversation

var $id : Text
var $targetUser : cs.User

$conversation.messages.push(cs.Message.new($text; $user))
$conversation:=chat_server_save($conversation)

For each ($id; $conversation.users.filter(Formula($1.value#String($user.id))))
	EXECUTE ON CLIENT($id; "chat_notify"; $conversation)
	$targetUser:=chat_server_user_by_id($id)
	EXECUTE ON CLIENT($id; "chat_update_unread"; chat_server_unread($targetUser; chat_server_conversations($targetUser)))
End for each 

return $conversation