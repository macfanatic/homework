require 'spec_helper'

describe Organization do

  describe '#users' do

    context 'without any' do
      it "returns empty array" do
        expect(subject.users).to be_a(Array)
        expect(subject.users).to be_empty
      end
    end

    context 'with a user' do
      let(:user) { User.new name: "Matt" }
      before do
        subject.stub(:user_roles).and_return([UserRole.new(user: user)])
      end

      it "returns the user instance" do
        expect(subject.users).to include user
      end
    end
  end

  describe '#add_user' do
    let(:user) { User.new name: "Matt" }

    it "adds the user to the collection" do
      expect do
        subject.add_user user, :user
      end.to change(subject.user_roles, :count).by(1)
    end

    it "sets the #organization on the User instance" do
      expect do
        subject.add_user user, :user
      end.to change { user.organization }.from(nil).to(subject)
    end
  end

end
