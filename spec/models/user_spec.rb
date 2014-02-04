require 'spec_helper'

describe User do
  let (:user){ 
  	User.new(:email => "test@example.com")
  }

  subject { user }

  it { should have_and_belong_to_many :books }

end