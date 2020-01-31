-- Эта программа принимает аргумент командной строки (arg [1]), который
-- указывает на входной файл.
-- На выходе показывает топ 100 встречаемых слов в порядке убывания.


local freq = {}
for line in io.lines(arg[1]) do
-- Возвращает копию строки s, где все большие буквы заменены на маленькие	
	local lowerline = string.lower(line)
-- Проход по всем словам; шаблон "[%a\128-\255]+" для кириллицы
	for word in string.gmatch(lowerline, "[%a\128-\255]+") do
		if not freq[word] then
			freq[word] = 1
		else
			freq[word] = freq[word] + 1
		end
	end
end

--так как в Lua нет массивов используются ассоциативные таблицы
local array = {}
for word, count in pairs(freq) do
	table.insert(array, {word, count})
end

table.sort(array, function (a, b) return a[2] > b[2] end) --сортировка таблицы

for i = 1, 100 do
	io.write(string.format('%d %s\n', array[i][2] , array[i][1]))
end