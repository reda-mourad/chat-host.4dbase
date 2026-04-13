//%attributes = {"shared":true}
#DECLARE($user : cs.User)
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
