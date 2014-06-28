require 'spec_helper'
describe BookPolicy do
  subject { BookPolicy }

  [:update?, :edit?, :show?, :index?, :destroy?].each do |permission|
    permissions permission do
      let(:first_user) { build_stubbed(:user_with_book) }
      let(:second_user) { build_stubbed(:user_with_book)}

      before :each do
        first_user.books.first.stub(:users).and_return([first_user])
        second_user.books.first.stub(:users).and_return([second_user])
      end

      context "when user is the owner" do
        it "grants access" do
          expect(subject).to permit(first_user, first_user.books.first)
        end

        it "denies access" do
          expect(subject).not_to permit(first_user, second_user.books.first)
        end    
      end

      context "when user is not the owner" do
        it "denies access" do
          expect(subject).not_to permit(second_user, first_user.books.first)
        end
      end

      context "when user is admin" do
        it "grants access" do
          expect(subject).to permit(build_stubbed(:user, :admin), first_user.books.first)
          expect(subject).to permit(build_stubbed(:user, :admin), second_user.books.first)
        end
      end
    end
  end
end