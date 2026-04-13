//%attributes = {"shared":true}
#DECLARE($messages : Collection; $containerWidth : Integer)->$form : Object

var $objects; $size; $circle; $rect; $input; $text; $btn; $stamp : Object
var $i : Integer
var $refBottom : Integer
var $msg : cs.Message
var $user : cs.User
var $date : Date
var $time : Time

$objects:={}

$form:={}
$form.bottomMargin:=10
$form.rightMargin:=10

For each ($msg; $messages)
	
	$msg.readBy:=$msg.readBy.push(Storage.chat.user.id).distinct()
	$user:=chat_server_user_by_id($msg.userId)
	
	$circle:={type: "oval"; top: $refBottom+10; left: 10; width: 40; height: 40; stroke: "#c0c0c0"}
	
	$text:={}
	$text.type:="text"
	$text.text:=$user.initials
	$text.top:=$circle.top+9
	$text.left:=$circle.left
	$text.height:=23
	$text.width:=$circle.width
	$text.stroke:="#3c3c3c"
	$text.fontWeight:="bold"
	$text.fontSize:=16
	$text.textAlign:="center"
	
	$btn:={type: "button"; style: "custom"}
	$btn.left:=$circle.left
	$btn.top:=$circle.top
	$btn.height:=$circle.height
	$btn.width:=$circle.width
	$btn.tooltip:=$user.name
	
	$size:=bestSize($msg.text; $containerWidth-$circle.left-$circle.width-$form.rightMargin-30)
	
	$rect:={type: "rectangle"; top: $refBottom+10; left: 60; width: $size.width+20; height: $size.height+20}
	$rect.borderRadius:=10
	$rect.stroke:="#c0c0c0"
	
	$input:={type: "input"; top: $rect.top+10; left: $rect.left+10; height: $size.height; width: $size.width}
	$input.dataSource:="Form.messages.at("+String($i)+").text"
	$input.enterable:=False
	$input.fill:="transparent"
	$input.borderStyle:="none"
	$input.tooltip:=$user.name
	
	$date:=Date($msg.stamp)
	$time:=Time($msg.stamp)
	
	$stamp:={}
	$stamp.type:="text"
	$stamp.text:=[String($date; Blank if null date); String($time; Blank if null time)].join(" ")
	$stamp.top:=$rect.top+$rect.height
	$stamp.left:=$rect.left
	$stamp.fontSize:=12
	$stamp.stroke:="#a0a0a0"
	//$stamp.height:=15
	//$stamp.width:=$containerWidth-$rect.left
	$size:=bestSize($stamp.text; $containerWidth-$circle.left-$circle.width-$form.rightMargin-30; $stamp)
	$stamp.height:=$size.height
	$stamp.width:=$stamp.width
	
	If ($msg.userId=Storage.chat.user.id)
		$rect.fill:="#faf0fd"
		$circle.fill:="#faf0fd"
	End if 
	
	$objects[Generate UUID]:=$circle
	$objects[Generate UUID]:=$text
	$objects[Generate UUID]:=$btn
	$objects[Generate UUID]:=$rect
	$objects[Generate UUID]:=$input
	$objects[Generate UUID]:=$stamp
	
	$refBottom:=[$stamp.top+$stamp.height; $circle.top+$circle.height].max()
	$i+=1
	
End for each 

$form.pages:=[{objects: $objects}]