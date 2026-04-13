//%attributes = {"shared":true}
#DECLARE($conversation : cs.Conversation; $user : cs.User)

var $participantIds : Collection
var $users : Collection
var $names : Text
var $id : Text

$participantIds:=$conversation.users.filter(Formula($1.value#$user.id))

If ($participantIds.length>1)
	
	If ($conversation.subject#"")
		$conversation["label"]:=$conversation.subject
		return 
	End if 
	
	If ($conversation.subject#"")
		$conversation["label"]:=This.subject
	End if 
	
	$users:=[]
	
	For each ($id; $participantIds)
		$users.push(chat_server_user_by_id($id))
	End for each 
	
	$names:=$users.slice(0; 2).map(Formula($1.value.name)).join(" & ")
	$names:=["Moi"; $names].join(", ")
	If ($participantIds.length>2)
		$names+=" +"+String($participantIds.length-3)
	End if 
	$conversation["label"]:=$names
	
End if 

If ($participantIds.length=1)
	$conversation["label"]:=chat_server_user_by_id($participantIds.first()).name
End if 