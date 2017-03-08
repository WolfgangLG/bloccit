require 'rails_helper'

RSpec.describe "sponsored_posts/edit", type: :view do
  before(:each) do
    @sponsored_post = assign(:sponsored_post, SponsoredPost.create!(
      :title => "MyString",
      :body => "MyText",
      :price => 1,
      :topic => nil
    ))
  end

  it "renders the edit sponsored_post form" do
    render

    assert_select "form[action=?][method=?]", sponsored_post_path(@sponsored_post), "post" do

      assert_select "input#sponsored_post_title[name=?]", "sponsored_post[title]"

      assert_select "textarea#sponsored_post_body[name=?]", "sponsored_post[body]"

      assert_select "input#sponsored_post_price[name=?]", "sponsored_post[price]"

      assert_select "input#sponsored_post_topic_id[name=?]", "sponsored_post[topic_id]"
    end
  end
end
