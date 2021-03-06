class BookController < ApplicationController
  before_action { @breadcrumbs.hidden=true } 
  def index
    
  end

  def show
    @chapter = BookChapter.where(:qr_code=>params[:id]).first or return not_found
    @graveyard=@chapter.graveyard
    @page_title=@chapter.title

    redirect_to @graveyard ? @graveyard.to_url : '/'
  end
end
