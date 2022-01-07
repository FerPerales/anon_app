json.extract! user, :id, :first_name, :last_name, :street_line1, :street_line2, :zipcode, :email, :salary_cents, :created_at, :updated_at
json.url user_url(user, format: :json)
