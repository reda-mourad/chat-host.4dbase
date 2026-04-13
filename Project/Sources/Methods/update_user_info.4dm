//%attributes = {"shared":true}
#DECLARE($name : Text; $initials : Text) : Boolean

var $ds:=remote_ds()
var $record : 4D.Entity
var $info : Object

$record:=$ds.Utilisateur.get(Storage.chat.user.id)

If ($record#Null)
	
	$record.Nom:=$name
	$record.Initiales:=$initials
	$info:=$record.save()
	chat_server_init()
	cs.Client.me.init(chat_server_user_by_id(Storage.chat.user.id))
	return $info.success
	
End if