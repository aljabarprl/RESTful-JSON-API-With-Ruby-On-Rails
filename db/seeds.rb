# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless User.exists?
  puts "Creating initial User..."
  User.create!(name: "Admin", email: "admin@example.com", password: "password") 
end

admin_user = User.first
puts "Admin User ID: #{admin_user.id}"

DUMMY_PHRASES = [
  "Riset mendalam untuk fitur otentikasi API",
  "Tulis spesifikasi endpoint V3",
  "Perbaiki bug minor di ItemsController",
  "Pelajari framework testing baru (Cypress)",
  "Buat skema database untuk modul pembayaran",
  "Revisi dokumentasi API untuk versi 1.5",
  "Optimasi query database yang lambat di index Todos",
  "Konfigurasi CI/CD pipeline di GitHub Actions",
  "Latihan coding interview (LeetCode Hard)",
  "Membaca buku 'Clean Code' bab 5",
  "Pesan kopi biji premium dari Brazil",
  "Rencanakan menu makan malam sehat untuk seminggu",
  "Atur jadwal tidur agar bangun lebih awal",
  "Lari pagi 5 km di taman kota",
  "Membersihkan meja kerja dan merapikan kabel",
  "Balas semua email yang menumpuk dari minggu lalu",
  "Memperbaiki laptop lama untuk didonasikan",
  "Tonton tutorial baru tentang Docker Compose",
  "Perbarui portofolio online dengan proyek Todo API",
  "Menyiram semua tanaman hias di balkon",
]

puts "Seeding 50 Todos and Items with rich data..."

# Seed 50 records
50.times do |i|
  phrase = DUMMY_PHRASES[i % DUMMY_PHRASES.length] 
  
  todo_title = "#{phrase} - Run #{i + 1}"
  
  todo = Todo.create!(
    title: todo_title, 
    user_id: admin_user.id 
  )
  
  item_name = "Sub-task: Check final details for #{phrase}"
  todo.items.create!(name: item_name, done: (i % 5 == 0)) # variation status

end

puts "Database seeding complete! Total Todos: #{Todo.count}"
