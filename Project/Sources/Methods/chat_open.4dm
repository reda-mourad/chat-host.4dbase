//%attributes = {"shared":true}
#DECLARE($type : Integer)
Use (Storage.chat)
    Storage.chat.formRef:=Open form window("Form1"; $type)
End use 
DIALOG("Form1")
CLOSE WINDOW(Storage.chat.formRef)
