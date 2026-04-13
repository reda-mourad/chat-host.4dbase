property id : Text
property users : Collection
property subject : Text
property messages : Collection


Class constructor($users : Collection; $subject : Text)
	If ($users=Null)
		throw({message: "Please provide the users"})
	End if 
	This.id:=Generate UUID()
	This.users:=$users.extract("id")
	This.subject:=$subject
	This.messages:=[]
	
	
Function addMessage($text : Text; $user : cs.User)->$message : cs.Message
	$message:=cs.Message.new($text; $user)
	This.messages.push($message)