//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($users : Collection)

$users:=$users || []

Use (Storage)
	Storage.chat:=New shared object("users"; $users.copy(ck shared))
	
End use 