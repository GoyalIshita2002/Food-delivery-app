json.status do
    json.code "200"
  end
  
  json.orders do 
    json.array! @orders do |order|  
    json.customer_name order&.customer&.username
    json.total_amount order&.cart&.total_amount
    json.partial! 'order', locals: { order: order }
    json.partial! 'address', locals: { address: order.customer_address }
    end
  end
  