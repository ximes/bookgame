class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :publish, :unpublish, :complete, :uncomplete]
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
    @chapters = @book.chapters.by_print_order
    
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "#{@book.title}",
               
               :layout                         => 'pdf.html.haml',
               #:cover                          => "",
               :page_size                      => "A5",
               :font_name                      => "courier",
               :header                         => { :font_size => 8, :center => @book.title},
               :footer                         => { :center => '[page] of [topage]', :font_size => 8},
               :disposition                    => 'attachment'
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

  # PATCH/PUT /chapter/1
  # PATCH/PUT /chapter/1.json
  def publish
    respond_to do |format|
      if @book.publish!
        format.html { redirect_to edit_book_path(@book), notice: 'Book successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_book_path(@book), alert: "Book is not publishable. Try to set all chapters as completed and then try again" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  def unpublish
    respond_to do |format|
      if @book.unpublish!
        format.html { redirect_to edit_book_path(@book), notice: 'Book successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_book_path(@book), alert: "Book is not unpublishable." }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapter/1
  # PATCH/PUT /chapter/1.json
  def complete
    respond_to do |format|
      if @book.complete!
        format.html { redirect_to edit_book_url(@book), notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_book_url(@book), alert: "Book was not completable. Check for the presence of #{LINK_REMOVED_TEXT} in the text" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapter/1
  # PATCH/PUT /chapter/1.json
  def uncomplete
    respond_to do |format|
      if @book.uncomplete!
        format.html { redirect_to edit_book_url(@book), notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      params.require(:book).permit(:title, :introtext, :page_format, :font_name, :font_google, :font_google_name, :credits,  :cover,:user_id)
    end
end
