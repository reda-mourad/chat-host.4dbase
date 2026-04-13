property id : Text
property name : Text
property initials : Text
property group : Object
property type : Integer


Class constructor($name : Text; $initials : Text)
	This.id:=Generate UUID()
	This.name:=$name
	This.initials:=$initials