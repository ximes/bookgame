require "spec_helper"

describe ChaptersController do
  describe "routing" do
    it "routes to #index" do
      get("/books/1/chapters").should route_to("chapters#index", :book_id => "1")
    end

    it "routes to #new" do
      get("/books/1/chapters/new").should route_to("chapters#new", :book_id => "1")
    end

    it "routes to #show" do
      get("/books/1/chapters/1").should route_to("chapters#show", :book_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/books/1/chapters/1/edit").should route_to("chapters#edit", :book_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/books/1/chapters").should route_to("chapters#create", :book_id => "1")
    end

    it "routes to #update" do
      put("/books/1/chapters/1").should route_to("chapters#update", :book_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/books/1/chapters/1").should route_to("chapters#destroy", :book_id => "1", :id => "1")
    end

  end
end
