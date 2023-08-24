json.documents do 
  json.array! @documents do |document|
    json.partial! 'document', locals: { document: document }
  end
end