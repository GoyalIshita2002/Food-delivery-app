
json.id add_on.id
json.name add_on.name
if add_on.items.present?
  a = add_on.items.where(is_delete: false)
  json.items a do |item|
    json.partial! 'item', locals: { item: item }
  end
end
