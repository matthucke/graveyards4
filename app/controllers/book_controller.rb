class BookController < ApplicationController
  def index

  end

  def show
    @chapter = BookChapter.where(:qr_code=>params[:id]).first or return not_found
    @page_title=@chapter.title
  end
end
