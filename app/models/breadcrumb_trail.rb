class BreadcrumbTrail
  attr_accessor :request, :parents, :here, :hidden

  def initialize(request)
    @request=request
    @parents=[]
    @here = Breadcrumb.new_from_request(request)
  end

  def add(breadcrumb_or_attrs)
    if breadcrumb_or_attrs.is_a?(Breadcrumb)
      @parents.push(breadcrumb_or_attrs)
    else
      @parents.push(Breadcrumb.new(breadcrumb_or_attrs))
    end
  end

  # set hidden=true to make invisible
  def hidden?
    !!self.hidden
  end

end