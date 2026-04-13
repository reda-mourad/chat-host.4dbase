//%attributes = {}
var $p : Integer

If (Application type=4D Remote mode)
	Use (Storage)
		OB REMOVE(Storage; "chat")
	End use 
	var $user:=chat_server_user_by_id(String(Request("ID ?") || 13))
	cs.Client.me.init($user)
	cs.Client.me.openLauncher()
	$win:=Open form window("Form2")
	DIALOG("Form2")
	CLOSE WINDOW($win)
	
End if 

If (Application info.SDIMode)
	QUIT 4D()
End if 