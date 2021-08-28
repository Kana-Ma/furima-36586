FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    municipality { '大阪市' }
    house_number { '1-1' }
    building_name { '大阪ハイツ' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
