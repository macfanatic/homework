require 'spec_helper'

describe DetermineUserAccessForOrganization do
  subject { DetermineUserAccessForOrganization.new organization: organization, user: user }

  it "raises error without required attributes" do
    service = DetermineUserAccessForOrganization.new
    expect { service.access_symbol }.to raise_error(ArgumentError)
  end

  context 'no explicit relationship to the organization' do
    let(:organization) { Organization.new }
    let(:user) { User.new }

    it "returns :denied" do
      subject.should be_denied
    end
  end

  context 'admin access' do
    let(:organization) { Organization.new }
    let(:user) { User.new }
    before { organization.add_user user, :admin }

    it { should be_admin }
    it { should_not be_user }
    it { should_not be_denied }
  end

  context 'user access' do
    let(:organization) { Organization.new }
    let(:user) { User.new }
    before { organization.add_user user, :user }

    it { should_not be_admin }
    it { should be_user }
    it { should_not be_denied }
  end

  context 'denied' do
    let(:organization) { Organization.new }
    let(:user) { User.new }
    before { organization.add_user user, :denied }

    it { should_not be_admin }
    it { should_not be_user }
    it { should be_denied }
  end

end
