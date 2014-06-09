require 'spec_helper'

describe User do

  describe '#admin_for?' do
    let(:organization) { Organization.new }

    it "delegates to the service" do
      DetermineUserAccessForOrganization.any_instance.should_receive(:admin?).and_return(true)

      expect(subject).to be_admin_for(organization)
    end
  end

  describe '#access_to?' do
    let(:organization) { Organization.new }

    it "delegates to the service" do
      DetermineUserAccessForOrganization.any_instance.should_receive(:user?).and_return(true)

      expect(subject).to have_access_to(organization)
    end
  end

  describe '#denied_access_to?' do
    let(:organization) { Organization.new }

    it "delegates to the service" do
      DetermineUserAccessForOrganization.any_instance.should_receive(:denied?).and_return(true)

      expect(subject).to be_denied_access_to(organization)
    end
  end

end
