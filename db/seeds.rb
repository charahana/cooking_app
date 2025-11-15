# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

if ENV["ADMIN_EMAIL"].present? && ENV["ADMIN_PASSWORD"].present?
  Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
    admin.password = ENV["ADMIN_PASSWORD"]
    admin.password_confirmation = ENV["ADMIN_PASSWORD"]
  end
end

if Rails.env.development?
  # ダミーユーザー
  user = User.find_or_create_by!(email: 'test@example.com') do |u|
    u.password = 'password'
    u.name = 'テストユーザー'
  end

  # ダミーレシピ
  5.times do |i|
    user.recipes.find_or_create_by!(title: "テストレシピ #{i + 1}") do |recipe|
      recipe.body = "このレシピはダミーデータです。"
    end
  end

  puts "Development seeds created!"
end
