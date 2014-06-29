require "spec_helper"

describe BooksController do
  describe "routing" do

    it "routes to #view" do
      get("/user/1/view").should route_to("users#view", :id => "1")
    end

  end
end
