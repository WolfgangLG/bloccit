require 'rails_helper'

RSpec.describe "votes/new", type: :view do
  before(:each) do
    assign(:vote, Vote.new(
      :value => 1,
      :user => nil,
      :post => nil
    ))
  end

  it "renders new vote form" do
    render

    assert_select "form[action=?][method=?]", votes_path, "post" do

      assert_select "input#vote_value[name=?]", "vote[value]"

      assert_select "input#vote_user_id[name=?]", "vote[user_id]"

      assert_select "input#vote_post_id[name=?]", "vote[post_id]"
    end
  end
end
