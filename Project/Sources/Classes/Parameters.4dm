property messageMaxAge : Integer
property color : Text


Class constructor($file : 4D.File)
	var $json : Object
	
	$json:=Try(JSON Parse($file.getText()))
	
	This.messageMaxAge:=Num($json.messageMaxAge)>0 ? Num($json.messageMaxAge) : 1