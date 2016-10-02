json.extract! case_request, :id, :content, :created_at, :updated_at
json.url case_request_url(case_request, format: :json)