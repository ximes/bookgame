class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :set_book, except: :map
  after_action :create_chapter_relations, only: [:create, :update]
  before_filter :authenticate_user!

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = policy_scope(@book.chapters)
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
  end

  def map
    @book = Book.find(params[:book_id])
    @chapters = policy_scope(@book.chapters)
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

    def create_chapter_relations

      chapters_linked = @chapter.fulltext.scan(/\[link_to_chapter (\w*)\]/).flatten.uniq

      @chapter.child_chapters.each {|c| c.destroy}

      unless chapters_linked.empty?
        chapters_linked.map do |child_chapter|
          chapter = Chapter.find_by_id(child_chapter)

          if chapter && chapter.book == @chapter.book
            @chapter.child_chapters.create!(:parent => @chapter, :chapter => chapter)
          else
            field = @chapter.fulltext.gsub(/\[link_to_chapter #{Regexp.quote(child_chapter)}\]/, "")
            @chapter.update({:fulltext => field})
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :introtext, :fulltext, :active, :death, :ending, :beginning, :book_id)
    end
end
