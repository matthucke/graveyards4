require 'spec_helper'

describe "visits/new" do
  before(:each) do
    assign(:visit, stub_model(Visit,
      :user => nil,
      :graveyard => nil,
      :visit_type => 1,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new visit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", visits_path, "post" do
      assert_select "input#visit_user[name=?]", "visit[user]"
      assert_select "input#visit_graveyard[name=?]", "visit[graveyard]"
      assert_select "input#visit_visit_type[name=?]", "visit[visit_type]"
      assert_select "textarea#visit_notes[name=?]", "visit[notes]"
    end
  end
end
