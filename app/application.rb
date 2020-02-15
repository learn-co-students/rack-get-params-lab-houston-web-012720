class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def matchitem(resp,req) 
      @@items.each do |item|
        resp.write "#{item}\n"
      end
  end
  def matchsearch(resp,req)
    search_term = req.params["q"]
      resp.write handle_search(search_term)
  end 
  def matchcart(resp,req)
    if @@cart.count > 0
    @@cart.each do |cart|
      resp.write "#{cart}\n"
     end
    else 
    resp.write "Your cart is empty"
   end 
  end 
  def add_item(resp, req)
    add_item = req.params["item"]
      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else 
        resp.write "We don't have that item"
      end
    
  end 

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      matchitem(resp,req)
    elsif req.path.match(/search/)
      matchsearch(resp,req)
    elsif req.path.match(/cart/)
      matchcart(resp,req)
    elsif req.path.match(/add/)
      add_item(resp,req)
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end


end
