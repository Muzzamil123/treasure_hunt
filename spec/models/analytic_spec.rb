require 'rails_helper'

describe Analytic, type: :model do
  describe 'analytic validations' do
    # analytic location tests
    describe 'analytic location and email validation' do
      context 'latitude and longitude with invalid values are passed' do
        subject(:analytic) { FactoryBot.build(:analytic, latitude: -20000, longitude: -40000) }
        before { analytic.valid? }

        it { should_not be_valid }
        it { expect(analytic.errors[:latitude].size).to eq(1) }
        it { expect(analytic.errors[:longitude].size).to eq(1) }
      end

      context 'latitude and longitude with empty values are passed' do
        subject(:analytic) { FactoryBot.build(:analytic, email: 'test@test.com', latitude: nil, longitude: nil) }
        before { analytic.valid? }

        it { should_not be_valid }
      end

      context 'Invalid email is passed' do
        subject(:analytic) { FactoryBot.build(:analytic, email: 'test', latitude: 31.5204, longitude: 74.3587) }
        before { analytic.valid? }

        it { should_not be_valid }
      end

      context 'empty email, latitude and longitude are passed' do
        subject(:analytic) { FactoryBot.build(:analytic, email: nil, latitude: nil, longitude: nil) }
        before { analytic.valid? }

        it { should_not be_valid }
      end

      context 'latitude and longitude with valid values are passed' do
        subject(:analytic) { FactoryBot.build(:analytic, email: 'test@test.com', latitude: 31.5204, longitude: 74.3587) }
        before { analytic.valid? }

        it { should be_valid }
      end

      context 'email, latitude and longitude with valid values are passed' do
        subject(:analytic) { FactoryBot.build(:analytic, email: 'test@test.com', latitude: 31.5204, longitude: 74.3587) }
        before { analytic.valid? }

        it { should be_valid }
      end
    end
  end
end