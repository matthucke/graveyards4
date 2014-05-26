class FeaturedSitesController < ApplicationController
  def index
    sites = FeaturedSite.order(:sort_order, :section)
    @sections = sites.group_by(&:section)
    self.page_title = "Featured Sites"
  end
end
