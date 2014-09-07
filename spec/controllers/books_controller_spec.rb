require 'spec_helper'

describe BooksController do
  before :each do
    login_user :user_with_book
  end

  let(:book) { @user.books.first}

  before :each do
    book.stub(:users).and_return([@user])
  end

  describe "GET index" do
    before :each do
      @second_book = create(:book, :publishable)
    end
    it "assigns all books as @books" do
      get :index
      assigns(:books).should eq([book])
      assigns(:other_books).should eq([@second_book])
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      get :show, {:id => book.to_param}
      assigns(:book).should eq(book)
    end
  end

  describe "GET new" do
    it "assigns a new book as @book" do
      get :new
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    it "assigns the requested book as @book" do
      get :edit, {:id => book.to_param}
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, {:book => book.attributes}
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => book.attributes}
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, {:book => book.attributes}
        response.should redirect_to(Book.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => { "title" => "invalid value" }}
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book" do
        # Assuming there are no other books in the database, this
        # specifies that the Book created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Book.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => book.to_param, :book => { "title" => "MyString" }}
      end

      it "assigns the requested book as @book" do
        put :update, {:id => book.to_param, :book => book.attributes}
        assigns(:book).should eq(book)
      end

      it "redirects to the book" do
        put :update, {:id => book.to_param, :book => book.attributes}
        response.should redirect_to(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => { "title" => "invalid value" }}
        assigns(:book).should eq(book)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book" do
      expect {
        delete :destroy, {:id => book.to_param}
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      delete :destroy, {:id => book.to_param}
      response.should redirect_to(books_url)
    end
  end
end
