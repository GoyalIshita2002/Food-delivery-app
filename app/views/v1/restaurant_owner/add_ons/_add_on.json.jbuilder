

json.id add_on.id
json.name add_on.name
if add_on.items.present?
  json.items  add_on.items do |item|
    json.partial! 'item', locals: { item: item }
  end
end