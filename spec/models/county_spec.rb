require 'spec_helper'

describe County do

  context "empty" do
    subject(:c) { County.new }
    it "wants a name" do
      expect(c.errors_on(:name)).to include("can't be blank")
    end
    it "wants a state" do
      expect(c.errors_on(:state)).to include("can't be blank")
    end
  end

  context "belonging to state" do
    before {
      @illinois = create(:illinois)
    }

    subject(:c) { County.new(:state=>@illinois, :name=>'De Witt')}

    it "sets path correctly" do
      #c.valid?
      c.set_default_path
      expect(c.path).to be == 'De-Witt'
    end
    it "sets full path correctly" do
      expect(c.state).to be == @illinois
      c.valid?
      expect(c.full_path).to be == 'Illinois/De-Witt'
    end
  end

  context "having a name" do
    before {
      @missouri = create(:missouri)
    }

    context "county of st louis" do
      subject(:c) { County.new(:state=>@missouri, :name=>'St. Louis', :type_name=>'County' )}

      it "should have fancy name" do
        expect(c.fancy_name).to be == 'St. Louis County'
      end
    end
    context "city of st louis" do
      subject(:c) { County.new(:state=>@missouri, :name=>'St. Louis', :type_name=>'City')}

      it "should have fancy name" do
        expect(c.fancy_name).to be == 'City of St. Louis'
      end

      it "should have state name" do
        expect(c.fancy_name_with_state).to be == "City of St. Louis, Missouri"
      end
    end

  end


end


