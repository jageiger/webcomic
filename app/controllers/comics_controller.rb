class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_admin, except: [:index, :show, :edit, :update]
  before_action :check_role, only: [:edit, :update]

  # GET /comics
  # GET /comics.json
  def index
    @comics = Comic.rank(:row_order).all
  end
  
  def update_row_order
    @comic = Comic.find(comic_params[:comic_id])
    @comic.row_order_position = comic_params[:row_order_position]
    @comic.save
    

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end
  
  # GET /comics/1
  # GET /comics/1.json
  def show
    #
    redirect_to selected_chapters_path(comic: @comic)
  end

  # GET /comics/new
  def new
    @comic = Comic.new
  end

  # GET /comics/1/edit
  def edit
  end

  # POST /comics
  # POST /comics.json
  def create
    @comic = Comic.new(comic_params)

    respond_to do |format|
      if @comic.save
        format.html { redirect_to @comic, notice: 'Comic was successfully created.' }
        format.json { render :show, status: :created, location: @comic }
      else
        format.html { render :new }
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comics/1
  # PATCH/PUT /comics/1.json
  def update
    respond_to do |format|
      if @comic.update(comic_params)
        format.html { redirect_to @comic, notice: 'Comic was successfully updated.' }
        format.json { render :show, status: :ok, location: @comic }
      else
        format.html { render :edit }
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comics/1
  # DELETE /comics/1.json
  def destroy
    @comic.destroy
    respond_to do |format|
      format.html { redirect_to comics_url, notice: 'Comic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comic
      @comic = Comic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comic_params
      params.require(:comic).permit(:comic_id, :title, :description, :cover, :logo, :banner, :row_order_position, :navbar, :num_chapters, :background_img, :color_one, :color_two, :color_three, :color_four)
    end
    
    def check_admin
      unless current_user.try(:admin?)
        redirect_to comics_path
      end
    end
    
    def check_role
      unless user_signed_in? # if you ain't signed in, you can't edit
        redirect_to comics_path
      else # you're signed in...
         @assignments = Assignment.all.select { |t| t.comic_id == @comic.id }
         @assignments = @assignments.select { |t| t.user_id == current_user.id }
         unless current_user.try(:admin?) || @assignments.any?
           redirect_to comics_path
         else
           @assignment = @assignments.first
           unless current_user.try(:admin?) || @assignment.role == 1
             redirect_to comics_path
           end
         end  
      end
    end
end
