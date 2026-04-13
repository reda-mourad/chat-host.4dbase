//%attributes = {"shared":true}
#DECLARE()->$form : Object
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
