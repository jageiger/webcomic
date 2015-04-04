class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:selected, :show]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.rank(:row_order).all
  end
  
  def update_row_order
    @page = Page.find(page_params[:page_id])
    @page.row_order_position = page_params[:row_order_position]
    @page.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end
  
  def selected
    @chapter = Chapter.find(params[:chapter])
    @pages = Page.rank(:row_order).all.select { |t| t.chapter == @chapter }
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
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
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
      params.require(:page).permit(:page_id, :image, :thumb, :description, :row_order_position, :chapter_id)
    end
end
