require 'spec_helper'

describe 'determing if user has access' do
  let(:organization) { Organization.new name: "Root" }
  let(:user) { User.new name: "Admin" }

  # Querying access just requires asking a user if
  # he has admin access, access, or is denied

  it "when user has admin to root organization" do
    organization.add_user user, :admin
    expect(user).to be_admin_for(organization)
  end

  it "when user has user-level access to root organization" do
    organization.add_user user, :user
    expect(user).to have_access_to(organization)
  end

  it "when user is denied access to root organization" do
    organization.add_user user, :denied
    expect(user).to be_denied_access_to(organization)
  end

  it "when user is not granted access to any organization at all" do
    expect(user).to be_denied_access_to(organization)
  end
end
