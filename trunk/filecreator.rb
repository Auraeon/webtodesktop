require 'hpricot'
require 'getData.rb'


def getApp(text,ar,file)
	stacks={}
	stacks=getunder(ar)
	
	stacks.each do |key,value|
		class_name=""
		class_name=value[:class]
		stylehash=geteleStyle(text,class_name)
		file.puts "@#{key.to_s}=stack #{hashstring(stylehash)} do"
		file.puts "background \"#{stylehash[:background]}\""
		value.each do |k,v|
			if(k==:class)
				class_name=v
			else
				putType(k,v,file)
			end
		end
		file.puts "end"
		#file.puts "style(#{key.to_s},#{hashstring(stylehash)})"
	end
	file.puts writeScript
end

def hashstring(hash)
str=""
	hash.each do |key,value|
		if(key.to_s!="background")
		if(str!="")
		str<<","
		end
		str<<":#{key}=>\"#{value}\""
		end
	end
	return str
end

def giveinner(eleID)
	return $doc.search("##{eleID}").inner_html
end

def findfun(eleID)
	$doc.search("##{eleID}").each do |but|
		return but.attributes['onclick']
	end
	puts but
	return but.attributes['onclick']
end

def putType(k,v,file)
	case v
	when "p"
		file.puts "para \"#{giveinner(k.to_s)}\", "
	when "button"
		file.puts "button \"#{giveinner(k.to_s)}\" do "
		file.puts findfun(k.to_s)
		file.puts "end"
	end
end

def writeScript
	$doc.search("script").each do |tryruby|
		if(tryruby.attributes['type']=="text/ruby")
			return tryruby.inner_html
		end
	end
end

$doc = open("work.html") { |f| Hpricot(f) }
ar= $doc/"html/body/div"
sty=$doc/"html/head/style"
text=sty.inner_text
open("created.rb","w") do |file|
	file.puts "Shoes.app do"
	getApp(text,ar,file)
	file.puts "end"
end
