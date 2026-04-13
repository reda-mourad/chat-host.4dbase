//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($id : Text)->$user : cs.User

$user:=Storage.users.find(Formula($1.value.id=$id))