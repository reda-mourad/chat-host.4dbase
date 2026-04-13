var $messages; $conversations : Collection
var $r; $l; $t; $b : Integer
var $form : Object
var $page : Integer
var $name : Text
var $c : cs.Conversation
var $user : cs.User
var $keywords : Text
var $group : Object
var $i : Integer

Case of 
	: (FORM Event.code=On Load)
		Form.groups:=remote_ds().Groupe.all().toCollection("xNum, Nom")
		
		For ($i; 0; Form.groups.length-1)
			$group:=Form.groups[$i]
			Form.groups[$i]:={id: $group.xNum; name: $group.Nom}
		End for 
		
		Form.selectedGroup:=Storage.chat.user.group
		SET WINDOW TITLE("Messagerie instantanée ["+Storage.chat.user.name+"]")
		Form.title:="Conversations"
		chat_updateForm()
		
		
	: (FORM Event.code=On Page Change)
		$page:=FORM Get current page()
		Form.selectedUsers:=[]
		
		Case of 
			: ($page=1)
				chat_updateForm()
				Form.title:="Conversations"
				
			: ($page=2)
				Form.title:="Nouveau message"
				Form.users:=chat_server_users(Storage.chat.user).sort(Formula($1.value.name<$1.value2.name))
				Form.userSearch:=""
				Form.currentConversation:=Null
				For each ($user; Form.users)
					$user["selected"]:=False
				End for each 
				Form.filteredUsers:=Form.users.filter(Formula($1.value.group.id=Form.selectedGroup.id))
				Form.subject:=""
				
			: ($page=3)
				Form.title:="Paramètres"
				//Form.msgLifeSpan:=20
				Form.setting1:={values: ["1"; "2"]; index: 0}
				Form.name:=Storage.chat.user.name
				Form.initials:=Storage.chat.user.initials
				
			: ($page=4)
				chat_updateForm(Form.currentConversation)
				Form.title:=Form.currentConversation.label
				
		End case 
		
	: (FORM Event.code=On Resize) && (FORM Get current page()=4)
		updateConversationForm(Form.currentConversation)
		
		
	: (FORM Event.code=On Before Keystroke) && (FORM Event.objectName="inputText@")
		chat_message()
		
	: (FORM Event.code=On Clicked) && (FORM Event.objectName="buttonSend@")
		chat_message()
		
		
	: (FORM Event.code=On Clicked) && (FORM Event.objectName="btnSave")
		update_user_info(Form.name; Form.initials)
		
		
	: (FORM Event.objectName="lbUsers") && (FORM Event.code=On Clicked)
		chat_contactFilter()
		
		
	: (FORM Event.objectName="inputSearch") && (FORM Event.code=On After Edit)
		$keywords:=Get edited text
		$keywords:=Split string($keywords; " "; sk ignore empty strings+sk trim spaces).join(" ")
		$keywords:=["@"; $keywords; "@"].join("")
		Form.filteredUsers:=Form.users.filter(Formula(($1.value.name=$keywords) && ($1.value.group.id=Form.selectedGroup.id)))
		
		
	: (FORM Event.objectName="btnGroup")
		var $menu:=Create menu()
		
		For each ($group; Form.groups)
			APPEND MENU ITEM($menu; $group.name)
			SET MENU ITEM PARAMETER($menu; -1; String($group.id))
			If (Form.selectedGroup.id=$group.id)
				SET MENU ITEM MARK($menu; -1; Char(18))
			End if 
		End for each 
		
		var $choice:=Dynamic pop up menu($menu; String(Form.selectedGroup.id); 193; 98)
		
		If ($choice#"")
			Form.subject:=""
			Form.selectedGroup:=Form.groups.find(Formula(String($1.value.id)=$choice))
			Form.selectedUsers:=[]
			Form.filteredUsers:=Form.users.filter(Formula($1.value.group.id=Form.selectedGroup.id))
			Form.userSearch:=""
			For each ($user; Form.filteredUsers)
				$user["selected"]:=False
			End for each 
		End if 
		
End case 

$name:=["OvalTab"; FORM Get current page()].join("")
OBJECT SET RGB COLORS(*; "OvalTab@"; "silver"; "white")
OBJECT SET RGB COLORS(*; $name; "silver"; "#faf0fd")
OBJECT SET ENTERABLE(*; "inputSubject"; Form.selectedUsers.length>1)
OBJECT SET RGB COLORS(*; "Rectangle4"; "silver"; Form.selectedUsers.length>1 ? "#faf0fd" : "white")