json.extract! donation, :id, :amount, :name, :city, :state, :country, :contact_number, :email, :created_at, :updated_at
json.url donation_url(donation, format: :json)