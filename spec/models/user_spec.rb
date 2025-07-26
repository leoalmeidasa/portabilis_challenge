require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(20) }

    it { should validate_presence_of(:email) }

    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    context 'when creating a new user' do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(8).is_at_most(20) }
      it { should validate_presence_of(:password_confirmation) }
    end

    context 'when updating an existing user' do
      subject { create(:user) }

      it 'does not require password' do
        subject.name = 'New Name'
        expect(subject).to be_valid
      end
    end
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(user: 0, admin: 1) }
  end

  describe 'callbacks' do
    it 'downcases email before saving' do
      user = build(:user, email: 'TEST@EXAMPLE.COM')
      user.save
      expect(user.email).to eq('test@example.com')
    end
  end

  describe 'scopes' do
    let!(:active_user) { create(:user, active: true) }
    let!(:inactive_user) { create(:user, :inactive) }
    let!(:admin_user) { create(:user, :admin) }
    let!(:regular_user) { create(:user, role: 'user') }

    describe '.active' do
      it 'returns only active users' do
        expect(User.active).to include(active_user)
        expect(User.active).not_to include(inactive_user)
      end
    end

    describe '.inactive' do
      it 'returns only inactive users' do
        expect(User.inactive).to include(inactive_user)
        expect(User.inactive).not_to include(active_user)
      end
    end

    describe '.by_role' do
      it 'returns users with specified role' do
        expect(User.by_role('admin')).to include(admin_user)
        expect(User.by_role('admin')).not_to include(regular_user)
      end
    end

    describe '.search_by_name' do
      let!(:john) { create(:user, name: 'John Doe') }
      let!(:jane) { create(:user, name: 'Jane Smith') }

      it 'returns users matching name query' do
        expect(User.search_by_name('John')).to include(john)
        expect(User.search_by_name('John')).not_to include(jane)
      end

      it 'is case insensitive' do
        expect(User.search_by_name('john')).to include(john)
      end
    end

    describe '.search_by_email' do
      let!(:user1) { create(:user, email: 'test@example.com') }
      let!(:user2) { create(:user, email: 'other@domain.com') }

      it 'returns users matching email query' do
        expect(User.search_by_email('example')).to include(user1)
        expect(User.search_by_email('example')).not_to include(user2)
      end
    end
  end

  describe 'ransackable attributes and associations' do
    it 'allows ransack search on specific attributes' do
      expect(User.ransackable_attributes).to eq(%w[id name email role])
    end

    it 'allows ransack search on user association' do
      expect(User.ransackable_associations).to eq(%w[user])
    end
  end

  describe 'instance methods' do
    describe '#admin?' do
      it 'returns true for admin users' do
        admin = build(:user, :admin)
        expect(admin.admin?).to be true
      end

      it 'returns false for non-admin users' do
        user = build(:user, role: 'user')
        expect(user.admin?).to be false
      end
    end

    describe '#user?' do
      it 'returns true for regular users' do
        user = build(:user, role: 'user')
        expect(user.user?).to be true
      end

      it 'returns false for admin users' do
        admin = build(:user, :admin)
        expect(admin.user?).to be false
      end
    end
  end
end