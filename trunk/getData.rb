# require 'rubygems'  
 require 'hpricot'  
 require 'getStyle.rb'
 #require 'pp'  
   
doc = open("work.html") { |f| Hpricot(f) }
big=doc.search("*").select{ |e| e.elem? }
#big=doc.search("html/body/*")
elements=[]
big.each do |e|
	elements<<e.name
end
#p elements

def geteleStyle(text,eleID)
	stylehash={}
	stylehash=getStyle(text)
	return stylehash[eleID]
end

def getunder(a)

	 a.each do |b|
		inh={}
		inner= b/"/*"
		inner.each do |x|
		if x.is_a? Hpricot::Elem
		if x.name!="div"
			inh[x.attributes['id'].intern]=x.name 
		elsif x.name=="div"
			inh[x.attributes['id'].intern]=x.name 
			getunder(b/"div")
		end
		end
		end
		inh[:class]=b.attributes['class']
		 $stack[b.attributes['id'].intern] = inh if b.is_a? Hpricot::Elem
	 end
	 return $stack
end

def getTitle(doc)
	puts (doc/:title).inner_html
end

 ar= doc/"html/body/div"  
 $stack={}  
 stacks={}  
 stacks=getunder(ar)
 p stacks
 getTitle(doc)
# p geteleStyle(text,"box1")