FactoryGirl.define do
  factory :admin do
    name 'John Admin'
    email 'whitney@example.com'
    phone_number '5558882222'
    car_make 'chevy'
    car_model 'aveo'
    car_passenger_capacity 4
    password 'secretpassword'
  end

end
