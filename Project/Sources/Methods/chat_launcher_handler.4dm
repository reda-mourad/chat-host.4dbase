//%attributes = {"shared":true}
If (String(FORM Event.objectName)#"")
	cs.Client.me.open()
	chat_server_conversations(Storage.chat.user)
End if 