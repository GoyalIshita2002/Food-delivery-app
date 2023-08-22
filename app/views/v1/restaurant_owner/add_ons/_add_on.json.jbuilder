
json.add_on do
  json.id add_on.id
  json.name add_on.name
  json.min_quantity add_on.min_quantity
  json.max_quantity add_on.max_quantity
  if add_on.items.present?
    json.items  add_on.items do |item|
      json.partial! 'item', locals: { item: item }
    end
  end
end