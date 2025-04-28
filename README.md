### SLComboboxCF

An implementation of a javafx combobox for B4j with Cell Factory.

Select the type of the cell required in the designer or set it in code:
`
SLComboboxCF1.celltype = SLComboboxCF1.CELLTYPE_GRAPHIC
`
before adding items.

Add items to the Combobox in the normal way:
`
Dim L As List = Array As String(1,2,3,4,5,6)
SLComboboxCF1.Items = L
`

Add the appropriate callback for the type of cell:
```
'ListCell is a descendant of Node, so we can cast it to a B4xView and use the styling provided
'by B4xView
Private Sub SLComboboxCF1_GetText(Cell As B4XView, Source As Object) As String
	Cell.TextColor = xui.Color_Blue
	Cell.SetTextAlignment("CENTER","LEFT")
	Return Source
End Sub

'Return a Node for the cell content.
Private Sub SLComboboxCF1_GetGraphic(Cell As B4XView, Source As Object) As Node
	If Source Is Map Then
		Return SetFromMap("cell",Source)
	Else
		Dim L As B4XView = CCF_Utils.NewLabel
		L.Text = Source
		L.TextColor = xui.Color_Red
		L.SetTextAlignment("CENTER","CENTER")
		'Need to set a width so the text can center.
		L.Width = SLComboboxCF1.mBase.Width - 30
		Return L
	End If
End Sub
```

If you wish to style the button cell, add a callback:
```
Private Sub SLComboboxCF1_SetButtonCell(Value As Object)
	Dim LCB As B4XView = CCF_Utils.NewListCell
	LCB.Text = Value
	LCB.TextColor = xui.Color_Blue
	LCB.SetTextAlignment("CENTER","LEFT")
	SLComboboxCF1.ButtonCell = LCB
End Sub
```

