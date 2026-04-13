//%attributes = {"shared":true}
#DECLARE($conversation : cs.Conversation)

var $message : cs.Message
var $user : cs.User

$message:=$conversation.messages.last()
$user:=chat_server_user_by_id($message.userId)

DISPLAY NOTIFICATION($user.name; $message.text)

CALL FORM(Num(Storage.chat.formRef); cs.Client.me.updateForm; $conversation)

