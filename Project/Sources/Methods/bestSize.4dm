//%attributes = {"shared":true}
#DECLARE($text : Text; $maxWidth : Integer; $props : Object)->$size : Object

var $form : Object
var $w; $h : Integer
var $ob : Object
var $key : Text

$size:={}
$ob:={type: "text"; top: 0; left: 0; height: 0; width: 0; text: $text}
If ($props#Null)
	For each ($key; OB Keys($props))
		$ob[$key]:=$props[$key]
	End for each 
End if 
$form:={pages: [{objects: {ob: $ob}}]}
FORM LOAD($form)
OBJECT GET BEST SIZE(*; "ob"; $w; $h; $maxWidth)
$size.width:=$w
$size.height:=$h
FORM UNLOAD