//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($user : cs.User; $conversations : Collection)->$unread : Integer

var $c : cs.Conversation

For each ($c; $conversations)
	If ($c.messages.some(Formula(Not($1.value.readBy.includes($user.id)))))
		$unread+=1
	End if 
End for each 
