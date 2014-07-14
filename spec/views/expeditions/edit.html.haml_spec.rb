require 'spec_helper'

describe "expeditions/edit" do
  before(:each) do
    @expedition = assign(:expedition, stub_model(Expedition,
      :user => nil,
      :name => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders the edit expedition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", expedition_path(@expedition), "post" do
      assert_select "input#expedition_user[name=?]", "expedition[user]"
      assert_select "input#expedition_name[name=?]", "expedition[name]"
      assert_select "textarea#expedition_notes[name=?]", "expedition[notes]"
    end
  end
end
