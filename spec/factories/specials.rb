FactoryBot.define do
  factory :special do
    product { '製品名１' }
    company { '会社名１' }
    detail { '製品名１の説明文' }
    per {'20.1'}
    status {'割高'}
    price {'200000'}

    after(:build) do |special|
      category = create(:category)
      special.special_category_relations << build(:special_category_relation, special: special, category: category)
    end
  end

  factory :second_special, class: Special do
    product { '製品名２' }
    company { '会社名２' }
    detail { '製品名２の説明文' }
    per {'11.1'}
    status {'割安'}
    price {'110000'}

    after(:build) do |special|
      category = create(:category)
      special.special_category_relations << build(:special_category_relation, special: special, category: category)
    end
  end
end
