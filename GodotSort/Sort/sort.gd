extends Node  
  
# 定义一个 RcdType 结构体或类的模拟，这里我们使用一个字典来模拟  
# 假设每个 RcdType 有一个 'key' 字段  
  
func Quick_Sort(r, low, high):  
	if low < high:  
		var i = low  
		var j = high  
		var t = r[low]  
  
		while i < j:  
			while i < j and r[j].key > t.key:  
				j -= 1  
			if i < j:  
				r[i] = r[j]  
				i += 1  
  
			while i < j and r[i].key <= t.key:  
				i += 1  
			if i < j:  
				r[j] = r[i]  
				j -= 1  
  
		r[i] = t  
  
		# 递归对左右子序列进行排序  
		Quick_Sort(r, low, i - 1)  
		Quick_Sort(r, i + 1, high)  
  
# 示例用法  
func _ready():  
	var records = [  
		{"key": 5},  
		{"key": 3},  
		{"key": 7},  
		{"key": 1},  
		{"key": 9},  
		{"key": 2},  
		{"key": 8},  
		{"key": 6},  
		{"key": 4}  
	]  
	  
	Quick_Sort(records, 0, records.size() - 1)  
	  
	for record in records:  
		print(record.key)
