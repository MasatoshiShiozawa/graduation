# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(
#    email: 'tanaka1@example.com',
#    name: '田中一郎',
#    admin: false,
#    password: 'tanaka'
# )
# User.create(
#    email: 'tanaka2@example.com',
#    name: '田中二郎',
#    admin: false,
#    password: 'tanaka'
# )
# User.create(
#    email: 'tanaka_admin@example.com',
#    name: '田中管理者',
#    admin: true,
#    password: 'tanaka'
# )

require "csv"

CSV.foreach('db/seeds/csv/user.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  User.create(
    id: row['id'],
    email: row['email'],
    name: row['name'],
    admin: row['admin'],
    password: row['password']
  )
end

CSV.foreach('db/seeds/csv/category.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  Category.create(
    id: row['id'],
    name: row['name']
  )
end

CSV.foreach('db/seeds/csv/special.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  Special.create(
    id: row['id'],
    product: row['product'],
    company: row['company'],
    image: File.open("#{Rails.root}#{row['image']}"),
    detail: row['detail'],
    per: row['per'],
    status: row['status'],
    price: row['price']
  )
end

CSV.foreach('db/seeds/csv/suii.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  Suii.create(
    id: row['id'],
    special_id: row['special_id'],
    date_friday: row['date_friday'],
    weekly_closing_price: row['weekly_closing_price']
  )
end

CSV.foreach('db/seeds/csv/comment.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  Comment.create(
    id: row['id'],
    special_id: row['special_id'],
    content: row['content'],
    user_id: row['user_id']
  )
end

CSV.foreach('db/seeds/csv/favorite.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  Favorite.create(
    id: row['id'],
    special_id: row['special_id'],
    user_id: row['user_id']
  )
end

CSV.foreach('db/seeds/csv/special_category_relation.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
  SpecialCategoryRelation.create(
    id: row['id'],
    special_id: row['special_id'],
    category_id: row['category_id']
  )
end
