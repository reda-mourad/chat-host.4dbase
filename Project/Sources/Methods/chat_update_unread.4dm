//%attributes = {"shared":true}
#DECLARE($unread : Integer)

var $text : Text

$text:=$unread>0 ? String($unread) : ""

CALL FORM(Num(Storage.chat.formLaunch); Formula(Form.unread:=$text))