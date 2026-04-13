//%attributes = {"shared":true}
#DECLARE()->$ds : 4D.DataStoreImplementation

var $config : Object

If (isComponent())
	
	$ds:=ds
	
Else 
	
	$config:=JSON Parse(Folder(fk resources folder).file("config.json").getText())
	$ds:=Open datastore({type: "4D Server"; hostname: [$config.host; $config.port].join(":")}; "Syseo")
	
End if 