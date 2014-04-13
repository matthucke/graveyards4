require 'spec_helper'

describe "counties/show" do
  before(:each) do
    @county = assign(:county, stub_model(County,
      :state => nil,
      :name => "Name",
      :type_name => 'County',
      :path => "Path",
      :full_path => "Full Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Path/)
    rendered.should match(/Full Path/)
  end
end
