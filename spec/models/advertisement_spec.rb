require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) {Advertisement.create!(title: "New Advertisement Title", body: "New Body Title", price: 1_000)}

  describe "attributes" do
    it "has a body, title, and price" do
      expect(advertisement).to have_attributes(title: "New Advertisement Title", body: "New Body Title", price: 1_000)
    end
  end
end
