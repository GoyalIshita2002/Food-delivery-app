json.status do
  json.code "200"
  json.message "File uploaded successfully"
end

json.document do
  json.partial! 'document', locals: { document: @document }
end