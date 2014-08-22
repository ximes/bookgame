class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:view, :download]

  # GET /books
  # GET /books.json
  def index
    @books = policy_scope(Book)
    @other_books = Book.publishable - @books
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  def view
    @book = Book.find(params[:id])
    @comments = @book.comments.recent.limit(10).all
  end

  def download
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "#{@book.title}",
               :disposition                    => 'attachment',
               :layout                         => 'pdf.html'
              #:cover                          => Rails.root + @book.cover.url(:hi_res),
               #:header => { :right => '[page] of [topage]' },
      end
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.users = [current_user]

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: 'Book was successfully created.' }
        format.json { render action: 'index', status: :created, location: book_url(@book) }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
      authorize @book
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :introtext, :page_format, :font_name, :font_google, :font_google_name, :credits,  :cover,:user_id, :active)
    end
end
