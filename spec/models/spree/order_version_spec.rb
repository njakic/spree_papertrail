require 'spec_helper'

RSpec.describe Spree::OrderVersion, :type => :model do
  ##############
  # attributes #
  ##############
  it { expect(subject).to respond_to :status }

  it { expect(subject).to respond_to :order_id }


  ################
  # associations #
  ################
  it { expect(subject).to belong_to :order }


  ###############
  # validations #
  ###############
  it "has a valid factory" do
    expect(FactoryGirl.build(:order_version)).to be_valid
  end

  it "has an invalid factory" do
    expect(FactoryGirl.build(:invalid_order_version)).to_not be_valid
  end

  it "should require an :order" do
    version = FactoryGirl.build(:order_version)
    version.order = nil

    expect(version.order).to be_nil
    expect(version).to have_at_least(1).errors_on(:order)
  end


  ###########
  # methods #
  ###########
  describe ":status" do
    it { expect(subject.status.class).to eq(Hash) }
  end
end
