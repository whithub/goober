require 'rails_helper'

RSpec.describe Ride, type: :model do

  # let(:user) { FactoryGirl.create(:user) }
  let(:ride) { FactoryGirl.create(:ride) }

  it { is_expected.to validate_presence_of(:pick_up_location) }
  it { is_expected.to validate_presence_of(:drop_off_location) }
  it { is_expected.to validate_presence_of(:num_of_passengers) }

  it { is_expected.to belong_to(:admin) }
  it { is_expected.to belong_to(:user) }

  xit "has a default status of 'active' " do
    expect(ride.status).to eq('active')
  end

  describe 'status' do
    subject { Ride.new }

    it { is_expected.to respond_to(:status) }

    describe ':active' do
      it 'is the initial state' do
        expect(subject.active?).to eql(true)
      end

      it 'can be transitioned to :accepted' do
        expect { subject.ride_accepted }.to change(subject, :accepted?).from(false).to(true)
      end

      it 'cannot be transitioned to :in_transit' do
        expect { subject.picked_up }.to raise_error(AASM::InvalidTransition)
      end

      it 'cannot be transitioned to :complete' do
        expect { subject.dropped_off }.to raise_error(AASM::InvalidTransition)
      end
    end

    describe ':accepted' do
      before { subject.status = :accepted }

      it 'cannot be transitioned back to :active' do
        expect { subject.ride_accepted }.to raise_error(AASM::InvalidTransition)
      end

      it 'can be transitioned to :in_transit' do
        expect { subject.picked_up }.to change(subject, :in_transit?).from(false).to(true)
      end

      it 'cannot be transitioned to :complete' do
        expect { subject.dropped_off }.to raise_error(AASM::InvalidTransition)
      end
    end

    describe ':in_transit' do
      before { subject.status = :in_transit }

      it 'cannot be transitioned back to :active' do
        expect { subject.ride_accepted }.to raise_error(AASM::InvalidTransition)
      end

      it 'cannot be transitioned back to :accepted' do
        expect { subject.ride_accepted }.to raise_error(AASM::InvalidTransition)
      end

      it 'can be transitioned to :complete' do
        expect { subject.dropped_off }.to change(subject, :complete?).from(false).to(true)
      end
    end

    describe ':complete' do
      before { subject.status = :complete }

      it 'cannot be transitioned back to :active' do
        expect { subject.ride_accepted }.to raise_error(AASM::InvalidTransition)
      end

      it 'cannot be transitioned back to :accepted' do
        expect { subject.ride_accepted }.to raise_error(AASM::InvalidTransition)
      end

      it 'cannot be transitioned back to :in_transit' do
        expect { subject.picked_up }.to raise_error(AASM::InvalidTransition)
      end
    end
  end

end
