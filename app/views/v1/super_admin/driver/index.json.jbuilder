json.code "200"
json.success true

json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end

json.driver do 
  json.array! @driver do |driver|
    json.id driver.id
    json.name driver.full_name
    json.email driver.email
    json.phone driver.phone
    order_agent = OrderAgent.find_by(driver_id: driver.id)
    if order_agent&.driver_id.present?
      json.status "busy"
    else
      json.status "available"
    end
  end
end
