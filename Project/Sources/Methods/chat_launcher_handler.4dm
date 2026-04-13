//%attributes = {"shared":true}
If (String(FORM Event.objectName)#"")
	chat_open(Plain form window)
	chat_server_conversations(Storage.chat.user)
End if