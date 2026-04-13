//%attributes = {"shared":true}
#DECLARE($conversation : cs.Conversation)

var $messages : Collection
var $form : Object
var $l; $t; $r; $b : Integer
var $msg : cs.Message

If ($conversation#Null)
	
	conversation_label($conversation)
	Form.title:=$conversation["label"]
	$conversation:=Form.conversations.find(Formula($1.value.id=$conversation.id))
	$messages:=$conversation.messages.reverse()
	OBJECT GET COORDINATES(*; "Subform"; $l; $t; $r; $b)
	$form:=buildConversationForm($messages; $r-$l)
	Form.subMessages:={messages: $messages}
	OBJECT SET SUBFORM(*; "Subform"; $form)
	chat_server_save($conversation)
	
End if