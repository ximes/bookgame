class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :set_book, except: :map
  before_filter :authenticate_user!

  # GET /chapters
  # GET /chapters.json
  def index
    all_chapters
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
  end

  def map
    @book = Book.find(params[:book_id])
    @chapters = policy_scope(@book.chapters)
    render layout: 'headless'
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
    @chapter.book = @book
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
        format.html { redirect_to book_chapter_path(@book, @chapter), notice: 'Chapter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chapter }
      else
        format.html { render action: 'new' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to book_chapter_path(@book, @chapter), notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to book_chapters_path(@book, @chapter) }
      format.json { head :no_content }
    end
  end

  def sort
    all_chapters
    @chapters.each do |chapter|
      chapter.position =  params['chapter'].index(chapter.id.to_s) +1
      chapter.save
    end
    head :ok, :content_type => 'text/html'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
      @book = Book.find(params[:book_id])
      authorize @chapter
      authorize @book
    end
    def set_book
      @book = Book.find(params[:book_id])
      authorize @book
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :introtext, :fulltext, :active, :death, :ending, :beginning, :book_id, :position)
    end

    def all_chapters
      @chapters = policy_scope(@book.chapters).by_order
    end
end