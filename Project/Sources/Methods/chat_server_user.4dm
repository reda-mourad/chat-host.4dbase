//%attributes = {"shared":true,"executedOnServer":true}
#DECLARE($index : Integer)->$user : cs.User

//cs.Server.me.init()
chat_server_init()
$user:=chat_server_user_by_id("13")
