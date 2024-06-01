extends Node
	
class dataToSort:
	var key:int
	var volumChart:float

var data:Array[dataToSort]
var startTime:float
var endTime:float
var sortElemSize:int
var timeAsSeed:bool
var descendingOrder:bool

@onready var desCheck = $Panel/DesCheck
@onready var elemSizeInput = $Panel/TextEdit
@onready var InfoLabel = $Panel/Info
@onready var seedInput = $Panel/Seed
@onready var timeAsSeedCheck = $Panel/TimeSeedCheck

@onready var elemContainer = $Panel/ElemContainer/VBoxContainer
@onready var listElem = preload("res://Sort/elem.tscn")

func _process(_delta):
	timeAsSeed = timeAsSeedCheck.button_pressed
	descendingOrder = desCheck.button_pressed

func clearContainer():
	for i in elemContainer.get_children():
		elemContainer.remove_child(i)

func _on_generate_pressed():
	var rng = RandomNumberGenerator.new()
	if timeAsSeed:
		rng.seed = hash(str(Time.get_datetime_dict_from_system()))
	else:
		rng.seed = hash(seedInput.text)
	
	data.clear()
	clearContainer()
	sortElemSize = int(elemSizeInput.text)
	startTime = Time.get_ticks_msec()
	
	for i in sortElemSize:
		var temp:dataToSort = dataToSort.new()
		temp.key = rng.randi_range(0,sortElemSize*5)
		temp.volumChart = float(temp.key) / (sortElemSize * 5)
		data.append(temp)
	
	endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
		
	InfoLabel.text = "Generate Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate generating time, not contain ui elem adding time"

func binaryInsertSort(list):
	var listSize = list.size()
	var low
	var high
	var mid
	var temp
	for i in range(1,listSize):
		temp = list[i]
		low = 0
		high = i - 1
		while(low <= high):
			mid = (low + high)/2
			if temp.key < list[mid].key:
				high = mid - 1
			else:
				low = mid + 1
		for j in range(i,low,-1):
			list[j] = list[j-1]
		list[low] = temp

func binaryInsertSort_desc(list):
	var listSize = list.size()
	var low
	var high
	var mid
	var temp
	for i in range(1, listSize):
		temp = list[i]
		low = 0
		high = i - 1
		while low <= high:
			mid = (low + high) / 2
			if temp.key > list[mid].key:
				high = mid - 1
			else:
				low = mid + 1
		for j in range(i - 1, low - 1, -1):
			list[j + 1] = list[j]
		list[low] = temp

func quickSort(list,low,high):
	var i = low
	var j = high
	var t = list[low]
	
	while(i<j):
		while(i<j and list[j].key >= t.key):
			j-=1
		if i<j:
			list[i] = list[j]
			i+=1
		while(i<j and list[i].key <= t.key):
			i+=1
		if i<j:
			list[j] = list[i]
			j-=1
	list[i] = t
	if low < i-1:
		quickSort(list,low,i-1)
	if high > i+1:
		quickSort(list,i+1,high)

func quickSort_desc(list,low,high):
	var i = low
	var j = high
	var t = list[low]
	
	while(i<j):
		while(i<j and list[j].key <= t.key):
			j-=1
		if i<j:
			list[i] = list[j]
			i+=1
		while(i<j and list[i].key >= t.key):
			i+=1
		if i<j:
			list[j] = list[i]
			j-=1
	list[i] = t
	if low < i-1:
		quickSort_desc(list,low,i-1)
	if high > i+1:
		quickSort_desc(list,i+1,high)

func insertSort(list):
	var listSize = list.size()
	for i in range(1, listSize):
		var temp = list[i]
		var j = i - 1
		while j >= 0 and list[j].key > temp.key:
			list[j + 1] = list[j]
			j -= 1
		list[j + 1] = temp

func insertSort_desc(list):
	var listSize = list.size()
	for i in range(1, listSize):
		var temp = list[i]
		var j = i - 1
		while j >= 0 and list[j].key < temp.key:
			list[j + 1] = list[j]
			j -= 1
		list[j + 1] = temp

func bubbleSort(list):
	var listSize = list.size()
	var swapped:bool
	for i in range(listSize - 1):
		swapped = true
		for j in range(listSize - i - 1):
			if list[j + 1].key < list[j].key:
				swapped = false
				var temp = list[j]
				list[j] = list[j + 1]
				list[j + 1] = temp
		if swapped:
			break

func bubbleSort_desc(list):
	var listSize = list.size()
	var swapped:bool
	for i in range(listSize - 1):
		swapped = false
		for j in range(listSize - i - 1):
			if list[j].key < list[j + 1].key:
				swapped = true
				var temp = list[j]
				list[j] = list[j + 1]
				list[j + 1] = temp
		if not swapped:
			break

func selectSort(list):
	var listSize = list.size()
	var k
	var temp
	for i in range(0,listSize):
		k = i
		for j in range(i+1,listSize):
			if list[j].key < list[k].key:
				k = j
		if i != k:
			temp = list[i]
			list[i] = list[k]
			list[k] = temp

func selectSort_desc(list):
	var listSize = list.size()
	var k
	var temp
	for i in range(0, listSize):
		k = i
		for j in range(i+1, listSize):
			if list[j].key > list[k].key:
				k = j
		if i != k:
			temp = list[i]
			list[i] = list[k]
			list[k] = temp

func heap(list, n, i):
	var largest = i
	var left = 2 * i + 1
	var right = 2 * i + 2
	if left < n and list[left].key > list[largest].key:
		largest = left
	if right < n and list[right].key > list[largest].key:
		largest = right
	if largest != i:
		var temp = list[i]
		list[i] = list[largest]
		list[largest] = temp
		heap(list, n, largest)

func heap_desc(list, n, i):
	var largest = i
	var left = 2 * i + 1
	var right = 2 * i + 2
	if left < n and list[left].key < list[largest].key:
		largest = left
	if right < n and list[right].key < list[largest].key:
		largest = right
	if largest != i:
		var temp = list[i]
		list[i] = list[largest]
		list[largest] = temp
		heap_desc(list, n, largest)

func heapSort(list):
	var listSize = list.size()
	for i in range(listSize / 2 - 1, -1, -1):
		heap(list, listSize, i)
	for i in range(listSize - 1, 0, -1):
		var temp = list[0]
		list[0] = list[i]
		list[i] = temp
		heap(list, i, 0)
		
func heapSort_desc(list):
	var listSize = list.size()
	for i in range(listSize / 2 - 1, -1, -1):
		heap_desc(list, listSize, i)
	for i in range(listSize - 1, 0, -1):
		var temp = list[0]
		list[0] = list[i]
		list[i] = temp
		heap_desc(list, i, 0)

func _on_quick_sort_pressed():
	if data.size() == 0:
		return
	clearContainer()
	if descendingOrder:
		startTime = Time.get_ticks_msec()
		quickSort_desc(data,0,data.size()-1)
		endTime = Time.get_ticks_msec()
	else:
		startTime = Time.get_ticks_msec()
		quickSort(data,0,data.size()-1)
		endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
	InfoLabel.text = "Algorithm : Quick Sort - Sort Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate sorting time, not contain ui elem adding time"

func _on_bubblesort_pressed():
	if data.size() == 0:
		return
	clearContainer()
	if descendingOrder:
		startTime = Time.get_ticks_msec()
		bubbleSort_desc(data)
		endTime = Time.get_ticks_msec()
	else:
		startTime = Time.get_ticks_msec()
		bubbleSort(data)
		endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
	InfoLabel.text = "Algorithm : Bubble Sort - Sort Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate sorting time, not contain ui elem adding time"

func _on_insert_sort_pressed():
	if data.size() == 0:
		return
	clearContainer()
	if descendingOrder:
		startTime = Time.get_ticks_msec()
		insertSort_desc(data)
		endTime = Time.get_ticks_msec()
	else:
		startTime = Time.get_ticks_msec()
		insertSort(data)
		endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
	InfoLabel.text = "Algorithm : Insertion Sort - Sort Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate sorting time, not contain ui elem adding time"

func _on_binsert_sort_pressed():
	if data.size() == 0:
		return
	clearContainer()
	if descendingOrder:
		startTime = Time.get_ticks_msec()
		binaryInsertSort_desc(data)
		endTime = Time.get_ticks_msec()
	else:
		startTime = Time.get_ticks_msec()
		binaryInsertSort(data)
		endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
	InfoLabel.text = "Algorithm : Binary Insertion Sort - Sort Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate sorting time, not contain ui elem adding time"

func _on_select_sort_pressed():
	if data.size() == 0:
		return
	clearContainer()
	if descendingOrder:
		startTime = Time.get_ticks_msec()
		selectSort_desc(data)
		endTime = Time.get_ticks_msec()
	else:
		startTime = Time.get_ticks_msec()
		selectSort(data)
		endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
	InfoLabel.text = "Algorithm : Select Sort - Sort Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate sorting time, not contain ui elem adding time"

func _on_heap_sort_pressed():
	if data.size() == 0:
		return
	clearContainer()
	if descendingOrder:
		startTime = Time.get_ticks_msec()
		heapSort_desc(data)
		endTime = Time.get_ticks_msec()
	else:
		startTime = Time.get_ticks_msec()
		heapSort(data)
		endTime = Time.get_ticks_msec()
	for i in data:
		var elemPrefab = listElem.instantiate()
		elemPrefab.labelValue = i.key
		elemPrefab.progressbarValue = i.volumChart
		elemContainer.add_child(elemPrefab)
	InfoLabel.text = "Algorithm : Heap Sort - Sort Time : " + str(endTime - startTime) + "ms" + "\nThis timer only calculate sorting time, not contain ui elem adding time"
