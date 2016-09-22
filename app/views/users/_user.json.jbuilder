json.extract! user, :id, :email, :first_name, :last_name, :mobile_number, :role, :created_at, :updated_at
json.url user_url(user, format: :json)