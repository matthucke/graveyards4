require 'spec_helper'

describe "expeditions/new" do
  before(:each) do
    assign(:expedition, stub_model(Expedition,
      :user => nil,
      :name => "MyString",
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new expedition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", expeditions_path, "post" do
      assert_select "input#expedition_user[name=?]", "expedition[user]"
      assert_select "input#expedition_name[name=?]", "expedition[name]"
      assert_select "textarea#expedition_notes[name=?]", "expedition[notes]"
    end
  end
end
