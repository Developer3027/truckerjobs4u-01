# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# destroy blogs
Blog.destroy_all
p "Confirmed #{Blog.count} blog articles records are left."

# destroy leads
Lead.destroy_all
p "Confirmed #{Lead.count} lead records are left."

# destroy newsletters
Newsletter.destroy_all
p "Confirmed #{Newsletter.count} newsletter records are left."

# destroy users
User.destroy_all
p "Confirmed #{User.count} User records are left."

# create user with user role
User.create!(email: "user@example.com", password: "password", role: "user")
p "Created one user with user role."

#create user with admin role
User.create!(email: "admin@example.com", password: "password", role: "admin")
p "Created one user with admin rol."

# create user with recruiter role
User.create!(email: "recruiter@example.com", password: "password", role: "recruiter")
p "Created one user with recruiter role."

# create user with advisor role
User.create!(email: "advisor@example.com", password: "password", role: "advisor")
p "Created one user with advisor role."

advisor_user = User.find_by(role: "advisor")
if advisor_user
  Blog.create!(title: "Hello World", content: "This is the first post", user_id: advisor_user.id)
  p "Created #{Blog.count} blog posts"
else
  p "No advisor user found"
end
