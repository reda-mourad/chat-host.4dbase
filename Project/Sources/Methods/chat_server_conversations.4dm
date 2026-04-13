//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($user : cs.User)->$conversations : Collection

var $ds:=remote_ds()
var $otherUser : cs.User
var $c : cs.Conversation
var $meta : Object

$conversations:=$ds.Conversation.all().toCollection("data").extract("data")
$conversations:=$conversations.filter(Formula($1.value.users.includes($user.id)))
$conversations:=$conversations.sort(Formula($1.value.messages.last().stamp>$1.value2.messages.last().stamp))

For each ($c; $conversations)
	conversation_label($c; $user)
	$meta:={}
	
	If (Not(is_read($c; $user)))
		$meta.fontWeight:="bold"
		$meta.stroke:="black"
	End if 
	
	$otherUser:=chat_server_user_by_id($c.users.find(Formula($1.value#$user.id)))
	
	Case of 
		: ($c.users.length>2)
			$meta.cell:={Column1: {stroke: "brown"}}
			
			
		: ($otherUser.type=1)
			$meta.cell:={Column1: {stroke: "tomato"}}
			
			
		: ($otherUser.type=2)
			$meta.cell:={Column1: {stroke: "teal"}}
			
			
		: ($otherUser.type=6)
			$meta.cell:={Column1: {stroke: "#9C27B0"}}
			
	End case 
	
	$c["meta"]:=$meta
	
End for each 

EXECUTE ON CLIENT($user.id; "chat_update_unread"; chat_server_unread($user; $conversations))