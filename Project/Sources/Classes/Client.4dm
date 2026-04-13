shared singleton Class constructor()
	
	
shared Function init($user : cs.User)
	var $chat : Object
	
	$chat:=Storage.chat || New shared object()
	
	Use ($chat)
		$chat.user:=OB Copy($user; ck shared; $chat)
	End use 
	
	Use (Storage)
		Storage.chat:=$chat
	End use 
	
	UNREGISTER CLIENT
	REGISTER CLIENT(String($user.id))
	
	If (OK=0)
		ALERT("Chat registration failed!")
	End if 
	
	SET USER ALIAS([$user.id; $user.name].join(" "))
	
	
shared Function buildLauncher()->$form : Object
	var $objects : Object
	var $ob : Object
	
	$objects:={}
	$form:={events: ["onClick"]; method: "chat_launcher_handler"; pages: [{objects: $objects}]}
	
	// bg
	$ob:={type: "oval"}
	$ob.top:=1
	$ob.left:=1
	$ob.height:=40
	$ob.width:=40
	$ob.stroke:="#c0c0c0"
	$objects[Generate UUID()]:=$ob
	
	// button
	$ob:={type: "button"}
	$ob.top:=1
	$ob.left:=1
	$ob.height:=40
	$ob.width:=40
	$ob.style:="custom"
	$ob.icon:="/RESOURCES/messages-square.svg"
	$objects[Generate UUID()]:=$ob
	
	// input
	$ob:={type: "input"}
	$ob.top:=1
	$ob.left:=11
	$ob.height:=18
	$ob.width:=30
	$ob.dataSource:="Form.unread"
	$ob.textAlign:="right"
	$ob.enterable:=False
	$ob.focusable:=False
	$ob.fill:="transparent"
	$ob.borderStyle:="none"
	$ob.fontWeight:="bold"
	$ob.fontSize:=18
	$objects[Generate UUID()]:=$ob
	
	
shared Function openLauncher()
	var $form:=This.buildLauncher()
	Use (Storage.chat)
		//Storage.chat.formLaunch:=Open form window($form; Form has no menu bar)
		Storage.chat.formLaunch:=Open window(Screen width()-45; Screen height()-45; 0; 0; Pop up window)
	End use 
	chat_server_conversations(Storage.chat.user)
	DIALOG($form; *)
	
	
shared Function open($type : Integer)
	Use (Storage.chat)
		Storage.chat.formRef:=Open form window("Form1"; $type)
	End use 
	DIALOG("Form1")
	CLOSE WINDOW(Storage.chat.formRef)
	
	
shared Function updateForm($conversation : cs.Conversation)
	var $c : cs.Conversation
	var $meta : Object
	var $userId : Text
	
	Form.conversations:=chat_server_conversations(Storage.chat.user).copy()
	$userId:=String(Storage.chat.user.id)
	
	If (FORM Get current page()=4) && (Form.currentConversation.id=$conversation.id)
		updateConversationForm($conversation)
	End if 
	
	
shared Function message()
	var $text : Text
	var $page : Integer
	
	$page:=FORM Get current page()
	$text:=Split string(Get edited text; " "; sk ignore empty strings+sk trim spaces).join(" ")
	
	If (Not(Shift down) && (Keystroke="\r"))
		If ($text#"") && ((Form.currentConversation#Null) || (Form.selectedUsers.length>0))
			Form.currentConversation:=Form.currentConversation || chat_server_conversation(Form.selectedUsers.concat(Storage.chat.user); Form.subject)
			Form.currentConversation:=chat_server_message(Storage.chat.user; Form.currentConversation; $text)
			Form.text:=""
			Form.textNew:=""
			FORM GOTO PAGE(4)
			This.updateForm(Form.currentConversation)
		End if 
		FILTER KEYSTROKE("")
	End if 
	
	
shared Function contactFilter()
	Form.selectedUsers:=Form.selectedUsers || []
	
	If (FORM Event.column#1)
		Form.filteredUsers.at(FORM Event.row-1).selected:=Not(Form.filteredUsers.at(FORM Event.row-1).selected)
		Form.filteredUsers:=Form.filteredUsers
	End if 
	
	Form.selectedUsers:=Form.filteredUsers.filter(Formula($1.value.selected))
	Form.subject:=""
	
	If (Form.selectedUsers.length>0)
		Form.subject:=Form.selectedUsers.slice(0; 2).map(Formula($1.value.name)).join(" + ")
		If (Form.selectedUsers.length>2)
			Form.subject+=" +"+String(Form.selectedUsers.length-2)
		End if 
	End if 
	OBJECT SET VISIBLE(*; "Static Picture2"; Form.selectedUsers.length<=1)
	OBJECT SET VISIBLE(*; "Static Picture3"; Form.selectedUsers.length>=2)