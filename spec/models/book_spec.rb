require 'spec_helper'

describe Book do
  let (:book){ 
  	Book.new(:title => "title")
  }

  subject { book }

  it { should have_and_belong_to_many :users }

end
