require 'spec_helper'

describe "expeditions/show" do
  before(:each) do
    @expedition = assign(:expedition, stub_model(Expedition,
      :user => nil,
      :name => "Name",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
