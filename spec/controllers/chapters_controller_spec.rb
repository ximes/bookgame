require 'spec_helper'

describe ChaptersController do
  before :each do
    login_user :user_with_book_and_chapters
  end

  let(:chapter) { @user.books.first.chapters.first}

  before :each do
    
  end

  describe "GET index" do
    it "assigns all chapters as @chapters" do
      get :index, {:book_id => chapter.book.id}
      assigns(:chapters).should eq([chapter])
    end
  end

  describe "GET show" do
    it "assigns the requested chapter as @chapter" do
      get :show, {:id => chapter.to_param, :book_id => chapter.book.id}
      assigns(:chapter).should eq(chapter)
    end
  end

  describe "GET new" do
    it "assigns a new chapter as @chapter" do
      get :new, {:book_id => chapter.book.id}
      assigns(:chapter).should be_a_new(Chapter)
    end
  end

  describe "GET edit" do
    it "assigns the requested chapter as @chapter" do
      get :edit, {:id => chapter.to_param, :book_id => chapter.book.id}
      assigns(:chapter).should eq(chapter)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Chapter" do
        expect {
          post :create, {:book_id => chapter.book.id, :chapter => chapter.attributes}
        }.to change(Chapter, :count).by(1)
      end

      it "assigns a newly created chapter as @chapter" do
        post :create, {:book_id => chapter.book.id, :chapter => chapter.attributes}
        assigns(:chapter).should be_a(Chapter)
        assigns(:chapter).should be_persisted
      end

      it "redirects to the created chapter" do
        post :create, {:book_id => chapter.book.id, :chapter => chapter.attributes}
        response.should redirect_to(book_chapter_path(chapter.book, Chapter.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved chapter as @chapter" do
        # Trigger the behavior that occurs when invalid params are submitted
        Chapter.any_instance.stub(:save).and_return(false)
        post :create, {:book_id => chapter.book.id, :chapter => { "title" => "invalid value" }}
        assigns(:chapter).should be_a_new(Chapter)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Chapter.any_instance.stub(:save).and_return(false)
        post :create, {:book_id => chapter.book.id, :chapter => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested chapter" do

        # Assuming there are no other chapters in the database, this
        # specifies that the Chapter created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Chapter.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:book_id => chapter.book.id, :id => chapter.to_param, :chapter => { "title" => "MyString" }}
      end

      it "assigns the requested chapter as @chapter" do

        put :update, {:book_id => chapter.book.id, :id => chapter.to_param, :chapter => chapter.attributes}
        assigns(:chapter).should eq(chapter)
      end

      it "redirects to the chapter" do

        put :update, {:book_id => chapter.book.id, :id => chapter.to_param, :chapter => chapter.attributes}
        response.should redirect_to(book_chapter_path(chapter.book, chapter))
      end
    end

    describe "with invalid params" do
      it "assigns the chapter as @chapter" do

        # Trigger the behavior that occurs when invalid params are submitted
        Chapter.any_instance.stub(:save).and_return(false)
        put :update, {:book_id => chapter.book.id, :id => chapter.to_param, :chapter => { "title" => "invalid value" }}
        assigns(:chapter).should eq(chapter)
      end

      it "re-renders the 'edit' template" do

        # Trigger the behavior that occurs when invalid params are submitted
        Chapter.any_instance.stub(:save).and_return(false)
        put :update, {:book_id => chapter.book.id, :id => chapter.to_param, :chapter => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested chapter" do
      expect {
        delete :destroy, {:book_id => chapter.book.id, :id => chapter.to_param}
      }.to change(Chapter, :count).by(-1)
    end

    it "redirects to the chapters list" do
      delete :destroy, {:book_id => chapter.book.id, :id => chapter.to_param}
      redirect_to(book_chapters_path(chapter.book))
    end
  end

end
