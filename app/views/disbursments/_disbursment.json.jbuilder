json.extract! disbursment, :id, :amount, :details, :case_id, :created_at, :updated_at
json.url disbursment_url(disbursment, format: :json)