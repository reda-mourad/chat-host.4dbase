//%attributes = {"shared":true}
#DECLARE($conversation : cs.Conversation)
var $c : cs.Conversation
var $meta : Object
var $userId : Text

Form.conversations:=chat_server_conversations(Storage.chat.user).copy()
$userId:=String(Storage.chat.user.id)

If (FORM Get current page()=4) && (Form.currentConversation.id=$conversation.id)
    updateConversationForm($conversation)
End if 
