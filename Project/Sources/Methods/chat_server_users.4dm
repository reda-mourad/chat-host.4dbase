//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($user : cs.User)->$users : Collection

$users:=Storage.users.filter(Formula($1.value.id#String($user.id)))
For each ($user; $users)
	
	Use ($user)
		
		Case of 
			: ($user.type=1)
				$user["_meta"]:=New shared object("stroke"; "tomato")
				
			: ($user.type=2)
				$user["_meta"]:=New shared object("stroke"; "teal")
				
			: ($user.type=6)
				$user["_meta"]:=New shared object("stroke"; "#9C27B0")
				
				
		End case 
		
	End use 
	
End for each 
