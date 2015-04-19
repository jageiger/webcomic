class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:selected, :show] #only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :qawsedrf, except: [:index, :selected, :show, :bookmark, :unbookmark, :new] #might need separate for new
  before_action :qawsedrf_new, only: [:new]

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.rank(:row_order).all
  end
  
  def update_row_order
    @chapter = Chapter.find(chapter_params[:chapter_id])
    @chapter.row_order_position = chapter_params[:row_order_position]
    @chapter.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end
  
  def selected
    @comic = Comic.find(params[:comic])
    @chapters = Chapter.rank(:row_order).all.select { |t| t.comic == @comic }
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    redirect_to selected_pages_path(chapter: @chapter)
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
    @comic = Comic.find(params[:comic])
    @chapter.comic = @comic
    
    @comic.num_chapters += 1
    @comic.save
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: 'Chapter was successfully created.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @comic = @chapter.comic
    @comic.num_chapters -= 1
    @comic.save
    
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to chapters_url, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:chapter_id, :title, :description, :cover, :num_pages, :row_order_position, :comic_id)
    end
    
    def qawsedrf
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
      @comic = Comic.find(params[:comic])

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
