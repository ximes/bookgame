require 'spec_helper'
describe ChapterPolicy do
  subject { ChapterPolicy }

  [:update?, :edit?, :show?, :index?, :destroy?, :index?].each do |permission|
    permissions permission do
      let(:chapter) { build_stubbed(:chapter_with_user)}

      before :each do
        @user = chapter.book.users.first
        chapter.stub_chain(:book, :users).and_return([@user])
      end

      context "when user is the owner" do
        it "grants access" do
          expect(subject).to permit(@user, chapter)
        end

        it "denies access" do
          expect(subject).not_to permit(build_stubbed(:user), chapter)
        end    
      end

      context "when user is not the owner" do
        it "denies access" do
          expect(subject).not_to permit(build_stubbed(:user), chapter)
        end
      end

      context "when user is admin" do
        it "grants access" do
          expect(subject).to permit(build_stubbed(:user, :admin), chapter)
        end
      end
    end
  end
end