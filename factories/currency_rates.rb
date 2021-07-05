FactoryBot.define do
  factory :currency_rate, class: Gera::CurrencyRate do
    cur_from { Money::Currency.find(:USD) }
    cur_to { Money::Currency.find(:RUB) }
    rate_value { 60 }
    association :snapshot, factory: :currency_rate_snapshot
    mode { :direct }
  end
end
