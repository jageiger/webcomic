class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:selected, :show, :bookmark, :unbookmark]
  before_action :qawsedrf, except: [:index, :selected, :show, :bookmark, :unbookmark, :new, :create] #might need separate for new
  before_action :qawsedrf_new, only: [:new]
  before_action :qawsedrf_create, only: [:create]
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.rank(:row_order).all
    # should redirect if not logged in, right?
  end
  
  def update_row_order
    @page = Page.find(page_params[:page_id])
    @page.row_order_position = page_params[:row_order_position]
    @page.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end
  
  def bookmark
    page = Page.find(params[:page_id])
    count = params[:count]
    cookies["page_#{page.id}".to_sym] = 1
    render inline: "MOOSE"
  end
  def unbookmark
    page = Page.find(params[:page_id])
    count = params[:count]
    cookies["page_#{page.id}".to_sym] = 0
    render nothing: true
  end
  
  def selected
    @count = 1
    if params[:page]
      @count = params[:page].to_i
    end
    
    @chapter = Chapter.find(params[:chapter])
    @comic = Comic.find(@chapter.comic_id)
    @pages = Page.rank(:row_order).all.select { |t| t.chapter == @chapter }
    unless user_signed_in?
      unless @pages.kind_of?(Array)
        @pages = @pages.page(params[:page]).per(1)
      else
        @pages = Kaminari.paginate_array(@pages).page(params[:page]).per(1)
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @chapter = @page.chapter
  end

  # GET /pages/new
  def new
    @page = Page.new
    
    @chapter = Chapter.find(params[:chapter])
    @page.chapter = @chapter
    
    @chapter.num_pages += 1
    @chapter.save
    
    @page.row_order = @chapter.num_pages
    # need a hidden field so this row_order attribute won't be lost
  end

  # GET /pages/1/edit
  def edit
    @chapter = @page.chapter
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @chapter = @page.chapter
    @chapter.num_pages -= 1
    @chapter.save
    
    @page.destroy
    respond_to do |format|
      format.html { redirect_to selected_pages_path(chapter: @chapter), notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:page_id, :image, :thumb, :description, :row_order_position, :chapter_id, :alt_tag)
    end
    
    def qawsedrf
    # in theory, I'll always have a @page object.
    puts "!*!***!**!"
    puts @page.chapter_id
    puts "!*!***!**!"
      @chapter = Chapter.find(@page.chapter_id)
      @comic = Comic.find(@chapter.comic_id)
      @assignments = Assignment.all.select { |t| t.comic_id == @comic.id }
      not_nil = -1
      if user_signed_in?
        not_nil = current_user.id
      end
     unless current_user.try(:admin?) || @assignments.select { |t| t.user_id == not_nil }.any?
        redirect_to comics_path
     end  
    end
    
    def qawsedrf_new
      @chapter = Chapter.find(params[:chapter])
      puts "!*!**!**^!"
      puts @chapter.id
      puts "!*!**!**^!"
      @comic = Comic.find(@chapter.comic_id)
      @assignments = Assignment.all.select { |t| t.comic_id == @comic.id }
      not_nil = -1
      if user_signed_in?
        not_nil = current_user.id
      end
     unless current_user.try(:admin?) || @assignments.select { |t| t.user_id == not_nil }.any?
        redirect_to comics_path
     end  
    end
    
    def qawsedrf_create
      @chapter = Chapter.find(page_params[:chapter_id])
      puts "!*!**!**^!"
      puts @chapter.id
      puts "!*!**!**^!"
      @comic = Comic.find(@chapter.comic_id)
      @assignments = Assignment.all.select { |t| t.comic_id == @comic.id }
      not_nil = -1
      if user_signed_in?
        not_nil = current_user.id
      end
     unless current_user.try(:admin?) || @assignments.select { |t| t.user_id == not_nil }.any?
        redirect_to comics_path
     end  
    end
    
    
end
