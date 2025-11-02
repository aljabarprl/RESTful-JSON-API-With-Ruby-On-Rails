# FactoryBot.define do
#   factory :item do
#     name { Faker::Lorem.word }
#     done { false }
#     todo 
#   end
# end

FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word } 
    done { false }
    todo 
  end
end