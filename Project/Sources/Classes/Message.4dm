property id : Text
property userId : Text
property text : Text
property stamp : Text
property readBy : Collection


Class constructor($text : Text; $user : cs.User)
	This.id:=Generate UUID()
	This.userId:=$user#Null ? $user.id : Storage.chat.user.id
	This.text:=$text
	This.stamp:=Timestamp
	This.readBy:=[This.userId]