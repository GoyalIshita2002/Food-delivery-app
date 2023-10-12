json.status do 
  json.code "200"
end

json.documents @documents do |document|
  json.partial! 'document', locals: { document: document}
end