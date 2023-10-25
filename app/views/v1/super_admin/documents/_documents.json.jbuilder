json.documents do 
  json.array! @restaurant_files do |document|
    json.partial! 'document', locals: { document: document }
  end
end