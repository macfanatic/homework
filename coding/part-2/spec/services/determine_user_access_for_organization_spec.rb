require 'spec_helper'

describe DetermineUserAccessForOrganization do
  let(:user) { User.new }
  subject { DetermineUserAccessForOrganization.new organization: organization, user: user }

  it "raises error without required attributes" do
    service = DetermineUserAccessForOrganization.new
    expect { service.access_symbol }.to raise_error(ArgumentError)
  end

  context 'directly with organization' do

    context 'no explicit relationship to the organization' do
      let(:organization) { Organization.new }

      it "returns :denied" do
        subject.should be_denied
      end
    end

    context 'admin access' do
      let(:organization) { Organization.new }
      before { organization.add_user user, :admin }

      it { should be_admin }
      it { should_not be_user }
      it { should_not be_denied }
    end

    context 'user access' do
      let(:organization) { Organization.new }
      before { organization.add_user user, :user }

      it { should_not be_admin }
      it { should be_user }
      it { should_not be_denied }
    end

    context 'denied' do
      let(:organization) { Organization.new }
      before { organization.add_user user, :denied }

      it { should_not be_admin }
      it { should_not be_user }
      it { should be_denied }
    end

  end

  context 'to organization with parent' do
    let(:root) { Organization.new name: "Root" }
    let(:organization) { Organization.new parent: root }

    context 'no relation to parent, just to direct organization' do
      before { organization.add_user user, :user }

      it { should be_user }
    end
    
    context 'admin to parent' do
      before { root.add_user user, :admin }

      it { should be_admin }

      context 'denied to local' do
        before { organization.add_user user, :denied }

        it { should be_denied }
      end

      context 'user-level to local' do
        before { organization.add_user user, :user }

        it { should be_user }
      end
    end

    context 'user-level to parent' do
      before { root.add_user user, :user }

      it { should be_user }

      context 'denied to local' do
        before { organization.add_user user, :denied }

        it { should be_denied }
      end

      context 'admin to local' do
        before { organization.add_user user, :admin }

        it { should be_admin }
      end
    end

    context 'denied to parent' do
      before { root.add_user user, :denied }

      context 'admin to local' do
        before { organization.add_user user, :admin }

        it { should be_admin }
      end

      context 'user-level to local' do
        before { organization.add_user user, :user }

        it { should be_user }
      end
    end

  end
end
