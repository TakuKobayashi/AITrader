# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.connection.execute("TRUNCATE TABLE #{AdminUser.table_name}")
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end
zaif = Mst::Zaif.find_or_create_by!(name: "Zaif", url: "https://zaif.jp/")
zaif.update!(max_maker_spread_rate: -0.05, max_taker_spread_rate: -0.01)
zaif.setup!