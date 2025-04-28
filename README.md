### SLComboboxCF

An implementation of a javafx combobox for B4j with Cell Factory.

Select the type of the cell required in the designer.

Add items to the Combobox in the normal way:

SLComboboxCF implements callbacks to get the data it needs for the cellfactory which are:

```
#Event: SetButtonCell(Value As Object)
#Event: GetGraphic(Cell As B4xView, Source as Object) As Node
#Event: GetText(Cell As B4xView, Source as Object) As String
```

`eventname_SetButtonCell` is called when the selected index is changed (before the call to SelectedIndexChanged) and gives the opportunity to set the appearance of the button cell to match (or not) the data in the Combobox dropdown. You need to explicitly set the button cell with a call to  the SLComboboxCF's `ButtonCell` method.

If the celltype is 'Text' a callback is made to `eventname_GetText'.  Cell inherits from Node, so it is cast to a B4xView the styling provided by B4xView can be used.

If the celltype is 'Graphic' a callback is made to `eventname_GetGraphic'. Which should return a Node with the required layout and data.

See the examples in the app for more details.

