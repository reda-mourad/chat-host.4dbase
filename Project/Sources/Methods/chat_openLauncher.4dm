//%attributes = {"shared":true}
var $form:=chat_buildLauncher()
Use (Storage.chat)
    //Storage.chat.formLaunch:=Open form window($form; Form has no menu bar)
    Storage.chat.formLaunch:=Open window(Screen width()-45; Screen height()-45; 0; 0; Pop up window)
End use 
chat_server_conversations(Storage.chat.user)
DIALOG($form; *)
