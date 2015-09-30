FactoryGirl.define do
  factory :ride do
    admin_id 1
    user_id  7
    status 'active'
    pick_up_location 'foo'
    drop_off_location 'bar'
    num_of_passengers 3
  end

end
