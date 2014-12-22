require 'spec_helper'

RSpec.describe Spree::OrderVersion, :type => :model do
  context "OrderVersionOptionTypeAndValueHelpers" do
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
    # Describe here you model associations behaviour.


    ###########
    # methods #
    ###########
    describe ":option_type_and_value_versions" do
      it { expect(described_class).to respond_to :option_type_and_value_versions }

      it { expect{described_class.option_type_and_value_versions}.to raise_error(ArgumentError) }
    end


    #######################
    # OptionTypes methods #
    #######################
    context "OptionTypes methods" do
      describe ":option_types_version_ids" do
        it { expect(subject).to respond_to :option_types_version_ids }

        it { expect{subject.option_types_version_ids}.to raise_error(ArgumentError) }

        it { expect(subject.option_types_version_ids(product_id: 1).class).to eq(Array) }

        it { expect(subject.option_types_version_ids(product_id: 1)).to be_empty }

        it { expect(subject.option_types_version_ids(product_id: 1)).to_not be_nil }
      end

      describe ":option_types" do
        it { expect(subject).to respond_to :option_types }

        it { expect{subject.option_types}.to raise_error(ArgumentError) }

        it { expect(subject.option_types(product_id: 1).class).to eq(Array) }

        it { expect(subject.option_types(product_id: 1)).to be_empty }

        it { expect(subject.option_types(product_id: 1)).to_not be_nil }
      end

      describe ":option_type_version_id" do
        subject { FactoryGirl.build(:order_version) }

        it { expect(subject).to respond_to :option_type_version_id }

        it { expect{subject.option_type_version_id}.to raise_error(ArgumentError) }

        it { expect(subject.option_type_version_id(option_type_id: 1).class).to eq(Fixnum) }

        it { expect(subject.option_type_version_id(option_type_id: 1)).to_not be_nil }

        context "with invalid :option_type_id" do
          it { expect(subject.option_type_version_id(option_type_id: 2)).to be_nil }
        end
      end

      describe ":option_type" do
        let(:option_type) { FactoryGirl.create(:option_type) }

        it { expect(subject).to respond_to :option_type }

        it { expect{subject.option_type}.to raise_error(ArgumentError) }

        it 'should eq Hash' do
          version = option_type.current_version
          status  = {
                      option_types_and_values: [{
                                                  product_id: 1,
                                                  version_id: 1,
                                                  variant_id: 1,
                                                  option_value_version_id: 1,
                                                  option_value_id: 1,
                                                  option_type_id: option_type.id,
                                                  option_type_version_id: version.id
                                                }]
                    }
          order_version = FactoryGirl.build(:order_version, status: status)

          expect(order_version.option_type(option_type_id: option_type.id).class).to eq(Spree::OptionType)
          expect(order_version.option_type(option_type_id: option_type.id)).to eq(version.reify)
          expect(order_version.option_type(option_type_id: option_type.id)).to eq(option_type)
        end
      end
    end


    ########################
    # OptionValues methods #
    ########################
    context "OptionValues methods" do
      describe ":option_values_version_ids" do
        it { expect(subject).to respond_to :option_values_version_ids }

        it { expect{subject.option_values_version_ids}.to raise_error(ArgumentError) }

        it { expect(subject.option_values_version_ids(variant_id: 1).class).to eq(Array) }

        it { expect(subject.option_values_version_ids(variant_id: 1)).to be_empty }

        it { expect(subject.option_values_version_ids(variant_id: 1)).to_not be_nil }
      end

      describe ":option_values" do
        it { expect(subject).to respond_to :option_values }

        it { expect{subject.option_values}.to raise_error(ArgumentError) }

        it { expect(subject.option_values(variant_id: 1).class).to eq(Array) }

        it { expect(subject.option_values(variant_id: 1)).to be_empty }

        it { expect(subject.option_values(variant_id: 1)).to_not be_nil }
      end

      describe ":option_value_version_id" do
        subject { FactoryGirl.build(:order_version) }

        it { expect(subject).to respond_to :option_value_version_id }

        it { expect{subject.option_value_version_id}.to raise_error(ArgumentError) }

        it { expect(subject.option_value_version_id(option_value_id: 1).class).to eq(Fixnum) }

        it { expect(subject.option_value_version_id(option_value_id: 1)).to_not be_nil }

        context "with invalid :option_value_id" do
          it { expect(subject.option_value_version_id(option_value_id: 2)).to be_nil }
        end
      end

      describe ":option_value" do
        let(:option_value) { FactoryGirl.create(:option_value) }

        it { expect(subject).to respond_to :option_value }

        it { expect{subject.option_value}.to raise_error(ArgumentError) }

        it 'should eq Hash' do
          version = option_value.current_version
          status  = {
                      option_types_and_values:  [{
                                                  product_id: 1,
                                                  version_id: 1,
                                                  variant_id: 1,
                                                  option_value_version_id: 1,
                                                  option_value_id: 1,
                                                  option_value_id: option_value.id,
                                                  option_value_version_id: version.id
                                                }]
                    }
          order_version = FactoryGirl.build(:order_version, status: status)

          expect(order_version.option_value(option_value_id: option_value.id).class).to eq(Spree::OptionValue)
          expect(order_version.option_value(option_value_id: option_value.id)).to eq(version.reify)
          expect(order_version.option_value(option_value_id: option_value.id)).to eq(option_value)
        end
      end
    end


    ##############################
    # OptionValues + OptionTypes #
    ##############################
    context "OptionValues + OptionTypes" do
      describe ":option_type_and_value_version_ids" do
        it { expect(subject).to respond_to :option_type_and_value_version_ids }

        it { expect{subject.option_type_and_value_version_ids}.to raise_error(ArgumentError) }

        it { expect(subject.option_type_and_value_version_ids(variant_id: 1).class).to eq(Array) }

        it { expect(subject.option_type_and_value_version_ids(variant_id: 1)).to be_empty }

        it { expect(subject.option_type_and_value_version_ids(variant_id: 1)).to_not be_nil }
      end
    end
  end
end
