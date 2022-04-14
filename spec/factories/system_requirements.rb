FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { "500gb" }
    processor { "AMD" }
    memory { "2gb" }
    video_board { "GeForce x" }
  end
end
