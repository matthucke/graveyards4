require 'spec_helper'

describe State do
  context "of nothingness" do
    subject(:state) { State.new }

    it "validates name" do
      expect(state.name).to be_nil
      expect(state).to_not be_valid
      expect(state.errors_on(:name)).to_not be_empty
    end

    it "validates country" do
      expect(subject.errors_on(:country_code)).to_not be_empty
    end
  end

  context "needing a path" do
    subject(:state) { State.new(:name => 'West Forgottonia') }

    it "should set path on validate" do
      expect(state.path).to be_blank
      state.valid?
      expect(state.path).to be == 'West-Forgottonia'
    end

  end

  context "cleaning names" do
    subject { State }

    it "should leave simple names alone" do
      expect(subject.name_to_path_element "Illinois").to be =="Illinois"
    end
    it "should clean complex names" do
      expect(subject.name_to_path_element("  Gtr.  /    Manchester!")).to be == "Gtr-Manchester"
    end
  end

  context "with duplicate name" do
    before {
      @adversary = create(:illinois)
    }

    subject {
      State.new(:name=>'Illinois', :country_code=>'US')
    }

    it "rejects duplicate name" do
      expect(@adversary).to be_persisted
      expect(subject.errors_on(:path)).to include('has already been taken')
    end

  end

end
