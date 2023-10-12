json.status do 
    json.code "200"
   end
json.dishes @order.cart.cart_items.map { |cart_item| cart_item.dish.name }


  
 

  