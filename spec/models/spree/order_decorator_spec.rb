require 'spec_helper'

RSpec.describe Spree::Order, :type => :model do
  ##############
  # attributes #
  ##############
  # Describe here you model attributes.


  ################
  # associations #
  ################
  it { expect(subject).to have_many(:order_versions).dependent(:destroy) }


  ###############
  # validations #
  ###############
  # Describe here you model validations behaviour.


  ###########
  # methods #
  ###########
  # Describe here you model methods behaviour.

end
