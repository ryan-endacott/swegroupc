json.array!(@submissions) do |submission|
  json.extract! submission, :id, :receipt, :user_id, :ip_address, :filename, :content_type, :file_contents
  json.url submission_url(submission, format: :json)
end
