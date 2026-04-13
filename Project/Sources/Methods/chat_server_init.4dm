//%attributes = {"shared":true,"executedOnServer":true}
var $users : Collection
var $ds:=remote_ds()
var $user : cs.User

$users:=$ds.Utilisateur.all().toCollection("xNumUser, Nom, Initiales, Groupe, Privilèges")

For each ($user; $users)
	
	$user.id:=String($user["xNumUser"])
	$user.name:=String($user["Nom"])
	$user.initials:=String($user["Initiales"])
	$user.group:=$ds["Groupe"].get($user["Groupe"]).toObject("xNum, Nom")
	$user.group:={id: $user.group.xNum; name: $user.group.Nom}
	$user.type:=$user["Privilèges"]
	OB REMOVE($user; "xNumUser")
	OB REMOVE($user; "Nom")
	OB REMOVE($user; "Initiales")
	OB REMOVE($user; "Groupe")
	OB REMOVE($user; "Privilèges")
	
End for each 

Use (Storage)
	Storage.users:=$users.copy(ck shared)
End use 