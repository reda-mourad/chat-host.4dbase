//%attributes = {"shared":true}
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
        chat_updateForm(Form.currentConversation)
    End if 
    FILTER KEYSTROKE("")
End if 
