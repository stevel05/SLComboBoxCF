B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'Class module WeakHashMap
'https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/WeakHashMap.html
Sub Class_Globals
	'Private fx As JFX 'Uncomment if required. For B4j only"
	'Private XUI As XUI 'Uncomment if required."

	Private Tjo As JavaObject
End Sub

Public Sub Initialize
	Tjo.initializeNewInstance("java.util.WeakHashMap", Null)
End Sub

'Removes all of the mappings from this map.
Public Sub Clear
	Tjo.Runmethod("Clear", Null)
End Sub

'Returns true if this map contains a mapping for the
'specified key.
Public Sub ContainsKey(key As Object) As Boolean
	Return Tjo.Runmethod("ContainsKey", Array(key))
End Sub

'Returns true if this map maps one or more keys to the
'specified value.
Public Sub ContainsValue(value As Object) As Boolean
	Return Tjo.Runmethod("ContainsValue", Array(value))
End Sub

'Returns a Set view of the mappings contained in this map.
'Return Type : Set
Public Sub EntrySet As JavaObject
	Return Tjo.Runmethod("EntrySet", Null)
End Sub

'Returns the value to which the specified key is mapped,
'or null if this map contains no mapping for the key.
'Return Type : V
Public Sub Get(key As Object) As Object
	Return Tjo.Runmethod("Get", Array(key))
End Sub

'Returns true if this map contains no key-value mappings.
Public Sub IsEmpty As Boolean
	Return Tjo.Runmethod("IsEmpty", Null)
End Sub

'Returns a Set view of the keys contained in this map.
'Return Type : Set
Public Sub KeySet As JavaObject
	Return Tjo.Runmethod("KeySet", Null)
End Sub

'Associates the specified value with the specified key in this map.
'Arg Type(s) : K, V,  Return Type : V
Public Sub Put(key As Object, value As Object) As Object
	Return Tjo.Runmethod("Put", Array(key, value))
End Sub

'Copies all of the mappings from the specified map to this map.
'Arg Type(s) : Map<?, ?
Public Sub PutAll(m As Map)
	Tjo.Runmethod("PutAll", Array(m))
End Sub

'Removes the mapping for a key from this weak hash map if it is present.
'Return Type : V
Public Sub Remove(key As Object) As Object
	Return Tjo.Runmethod("Remove", Array(key))
End Sub

'Returns the number of key-value mappings in this map.
Public Sub Size As Int
	Return Tjo.Runmethod("Size", Null)
End Sub

'Returns a Collection view of the values contained in this map.
'Return Type : Collection
Public Sub Values As JavaObject
	Return Tjo.Runmethod("Values", Null)
End Sub

