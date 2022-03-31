require 'rails_helper'

describe Winner, type: :model do
  describe 'winner validations' do
    # winner tests
    describe 'winners model validation' do
      context 'when wrong email is passed' do
        subject(:winner) { FactoryBot.build(:winner, email: 'test', last_location: '31.5204,74.3587') }
        before { winner.valid? }

        it { should_not be_valid }
        it { expect(winner.errors[:email].size).to eq(1) }
      end

      context 'when nil email is passed' do
        subject(:winner) { FactoryBot.build(:winner, email: nil, last_location: '31.5204,74.3587') }
        before { winner.valid? }

        it { should_not be_valid }
      end

      context 'when nil last_location is passed' do
        subject(:winner) { FactoryBot.build(:winner, email: 'test@test.com', last_location: nil) }
        before { winner.valid? }

        it { should_not be_valid }
      end

      context 'when correct last_location and email is passed' do
        subject(:winner) { FactoryBot.build(:winner, email: 'test@test.com', last_location: '31.5204,74.3587') }
        before { winner.valid? }

        it { should be_valid }
      end

    end
  end
end