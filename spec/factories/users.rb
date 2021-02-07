FactoryBot.define do
  factory :user do
    name { '鈴木一' }
    email { 'suzuki_test01@example.com' }
    password { 'suzuki' }
    admin { false }
  end
  factory :second_user, class: User do
    name { '鈴木二' }
    email { 'suzuki_test02@example.com' }
    password { 'suzuki' }
    admin { false }
  end
  factory :third_user, class: User do
    name { '鈴木五十一' }
    email { 'suzuki_test51@example.com' }
    password { 'suzuki' }
    admin { true }
  end
end
