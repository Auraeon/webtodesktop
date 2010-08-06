require 'hpricot'  
#
doc = open("work.html") { |f| Hpricot(f) }
#
def getStyle(text)
styles=[]
eachsty=[]
hash={}
	
	text.split(/\{|\}/).each do |word|
		eachsty << word
	end
	
	(0..eachsty.length-1).step(2) do |i|
		stylename=""
		eachsty[i].scan(/\w+/) {|x| stylename=x}
		hash[stylename]=eachsty[i+1]
	end
	#p hash
	hash.each do |key,value|
	prop=[]
	fh={}
	temp=[]
	if value!=nil 
		value.split(/;/).each do |word|
			prop << word
		end
		prop.each do |string|
			string.split(/:/).each do |word|
				temp << word
			end
		end
		#p temp
		(0..temp.length-1).step(2) do |i|
			fh[temp[i].intern]=temp[i+1]
		end
		hash[key]=fh
		
		#p fh
	end
	end
	#puts "After wards"
	css={}
	hash.each do |key,value|
		if value!=nil
			css[key]=value
		end
	end
	return css
end

sty=doc/"html/head/style"
text=sty.inner_text
stylehash={}
stylehash=getStyle(text)
p stylehash