require 'spec_helper'

describe UserRole do

  describe 'permissions' do
    context 'user level' do
      subject { UserRole.new role: :user }

      it { should_not be_admin }
      it { should be_user }
      it { should_not be_denied }
    end

    context 'admin level' do
      subject { UserRole.new role: :admin }

      it { should be_admin }
      it { should_not be_user }
      it { should_not be_denied }
    end

    context 'denied' do
      subject { UserRole.new role: :denied }

      it { should_not be_admin }
      it { should_not be_user }
      it { should be_denied }
    end
  end

end
