# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者情報
Admin.create!(email: "admin@admin.jp",
             password:  "11111111",
             password_confirmation: "11111111",
             )

Genre.create!(name: "ケーキ"
              )

10.times do |n|
  item = Item.new(
    genre_id: 1,
    name: "チョコレートケーキ",
    caption: "商品説明1",
    price: 500,
    is_active: true
  )
  File.open('./app/assets/images/cakes/chocolatecake.jpg') do |file|
    item.image = file
  end
  item.image_id = item.image.id
  item.save
end
