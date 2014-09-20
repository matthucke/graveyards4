require 'spec_helper'

describe CountyPathIndex do
  before(:all) {
    County.delete_all
    CountyPathIndex.reset!

    @klendathu = create(:klendathu)

    @counties = 9.times.map {
      c = County.create(
          state: create(:illinois),
          name: Faker::Name.last_name
      )
    }.compact

    CountyPathIndex.reset!
  }

  context "find a county" do
    subject { CountyPathIndex }

    it "does lookup" do
      expect( subject.county_id("Illinois/Klendathu") ).to be == @klendathu.id
    end
  end

  context "with many counties" do
    subject { CountyPathIndex }
    its(:size) { should be == 10 }
  end

  context "with cache" do
    subject { CountyPathIndex }
    it "puts in cache" do
      expect(Rails.cache.read(CountyPathIndex::CACHE_KEY)).to be_kind_of Hash
    end

    it "::reset!" do
      cached =Rails.cache.read(CountyPathIndex::CACHE_KEY)
      expect(cached).to be_kind_of Hash
      expect(cached).to be == CountyPathIndex.contents

      expect(CountyPathIndex.reset!).to be_nil
      expect(Rails.cache.read(CountyPathIndex::CACHE_KEY)).to be_nil

      expect { CountyPathIndex.contents }.to change { CountyPathIndex.load_count }.by(1)
      expect(CountyPathIndex.contents).to be_kind_of Hash

    end
  end
end
