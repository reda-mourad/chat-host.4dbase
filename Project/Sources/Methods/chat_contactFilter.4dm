//%attributes = {"shared":true}
Form.selectedUsers:=Form.selectedUsers || []

If (FORM Event.column#1)
    Form.filteredUsers.at(FORM Event.row-1).selected:=Not(Form.filteredUsers.at(FORM Event.row-1).selected)
    Form.filteredUsers:=Form.filteredUsers
End if 

Form.selectedUsers:=Form.filteredUsers.filter(Formula($1.value.selected))
Form.subject:=""

If (Form.selectedUsers.length>0)
    Form.subject:=Form.selectedUsers.slice(0; 2).map(Formula($1.value.name)).join(" + ")
    If (Form.selectedUsers.length>2)
        Form.subject+=" +"+String(Form.selectedUsers.length-2)
    End if 
End if 
OBJECT SET VISIBLE(*; "Static Picture2"; Form.selectedUsers.length<=1)
OBJECT SET VISIBLE(*; "Static Picture3"; Form.selectedUsers.length>=2)
