Shoes.app do
@stack1=stack :width=>"200px",:float=>"left" do
background "#eee"
button "Button" do 
add_para
end
end
@stack2=stack :width=>"200px",:float=>"left" do
background "#333"
para "Hi there i am in "
end

def add_para
	@stack2.append do
		para "This is again a generated text", :stroke=>white
	end
end
end
