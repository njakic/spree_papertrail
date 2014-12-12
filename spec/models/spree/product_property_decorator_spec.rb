require 'spec_helper'

RSpec.describe Spree::ProductProperty, :type => :model do
  ##############
  # attributes #
  ##############
  # Describe here you model attributes.


  ################
  # associations #
  ################
  # Describe here you model associations behaviour.


  ###############
  # validations #
  ###############
  # Describe here you model validations behaviour.


  ###########
  # methods #
  ###########
  it { expect(subject).to respond_to :versions }

  it { expect(subject).to respond_to :current_version }

  it { expect(subject).to respond_to :current_version_id }
end
