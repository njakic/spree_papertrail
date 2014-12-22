require 'spec_helper'

RSpec.describe Spree::OrderVersion, :type => :model do
  context "OrderVersionProductPropertyHelpers" do
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
    describe ":product_property_versions" do
      it { expect(described_class).to respond_to :product_property_versions }

      it { expect{described_class.product_property_versions}.to raise_error(ArgumentError) }
    end


    #############################
    # ProductProperties methods #
    #############################
    context "ProductProperties methods" do
      describe ":product_properties_version_ids" do
        it { expect(subject).to respond_to :product_properties_version_ids }

        it { expect{subject.product_properties_version_ids}.to raise_error(ArgumentError) }

        it { expect(subject.product_properties_version_ids(product_id: 1).class).to eq(Array) }

        it { expect(subject.product_properties_version_ids(product_id: 1)).to be_empty }

        it { expect(subject.product_properties_version_ids(product_id: 1)).to_not be_nil }
      end

      describe ":product_properties" do
        it { expect(subject).to respond_to :product_properties }

        it { expect{subject.product_properties}.to raise_error(ArgumentError) }

        it { expect(subject.product_properties(product_id: 1).class).to eq(Array) }

        it { expect(subject.product_properties(product_id: 1)).to be_empty }

        it { expect(subject.product_properties(product_id: 1)).to_not be_nil }
      end

      describe ":product_property_version_id" do
        subject { FactoryGirl.build(:order_version) }

        it { expect(subject).to respond_to :product_property_version_id }

        it { expect{subject.product_property_version_id}.to raise_error(ArgumentError) }

        it { expect(subject.product_property_version_id(product_property_id: 1).class).to eq(Fixnum) }

        it { expect(subject.product_property_version_id(product_property_id: 1)).to_not be_nil }

        context "with invalid :product_property_id" do
          it { expect(subject.product_property_version_id(product_property_id: 2)).to be_nil }
        end
      end

      describe ":product_property" do
        let(:product_property) { FactoryGirl.create(:product_property) }

        it { expect(subject).to respond_to :product_property }

        it { expect{subject.product_property}.to raise_error(ArgumentError) }

        it 'should eq Hash' do
          version = product_property.current_version
          status  = {
                      product_properties: [{
                                              product_id: 1,
                                              variant_id: 1,
                                              property_version_id: 1,
                                              property_id: 1,
                                              product_property_id: product_property.id,
                                              product_property_version_id: version.id
                                            }]
                    }
          order_version = FactoryGirl.build(:order_version, status: status)

          expect(order_version.product_property(product_property_id: product_property.id).class).to eq(Spree::ProductProperty)
          expect(order_version.product_property(product_property_id: product_property.id)).to eq(version.reify)
          expect(order_version.product_property(product_property_id: product_property.id)).to eq(product_property)
        end
      end
    end


    ######################
    # Properties methods #
    ######################
    context "Properties methods"  do
      describe ":properties_version_ids" do
        it { expect(subject).to respond_to :properties_version_ids }

        it { expect{subject.properties_version_ids}.to raise_error(ArgumentError) }

        it { expect(subject.properties_version_ids(product_id: 1).class).to eq(Array) }

        it { expect(subject.properties_version_ids(product_id: 1)).to be_empty }

        it { expect(subject.properties_version_ids(product_id: 1)).to_not be_nil }
      end

      describe ":properties" do
        it { expect(subject).to respond_to :properties }

        it { expect{subject.properties}.to raise_error(ArgumentError) }

        it { expect(subject.properties(product_id: 1).class).to eq(Array) }

        it { expect(subject.properties(product_id: 1)).to be_empty }

        it { expect(subject.properties(product_id: 1)).to_not be_nil }
      end

      describe ":property_version_id" do
        subject { FactoryGirl.build(:order_version) }

        it { expect(subject).to respond_to :property_version_id }

        it { expect{subject.property_version_id}.to raise_error(ArgumentError) }

        it { expect(subject.property_version_id(property_id: 1).class).to eq(Fixnum) }

        it { expect(subject.property_version_id(property_id: 1)).to_not be_nil }

        context "with invalid :property_id" do
          it { expect(subject.property_version_id(property_id: 2)).to be_nil }
        end
      end

      describe ":property" do
        let(:property) { FactoryGirl.create(:property) }

        it { expect(subject).to respond_to :property }

        it { expect{subject.property}.to raise_error(ArgumentError) }

        it 'should eq Hash' do
          version = property.current_version
          status  = {
                      product_properties: [{
                                              product_id: 1,
                                              variant_id: 1,
                                              property_version_id: version.id,
                                              property_id: property.id,
                                              product_property_id: 1,
                                              product_property_version_id: 1
                                            }]
                    }
          order_version = FactoryGirl.build(:order_version, status: status)

          expect(order_version.property(property_id: property.id).class).to eq(Spree::Property)
          expect(order_version.property(property_id: property.id)).to eq(version.reify)
          expect(order_version.property(property_id: property.id)).to eq(property)
        end
      end
    end


    ##########################################
    # ProductProperties + Properties methods #
    ##########################################
    context "ProductProperties + Properties methods" do
      describe ":product_property_and_property_version_ids" do
        it { expect(subject).to respond_to :product_property_and_property_version_ids }

        it { expect{subject.product_property_and_property_version_ids}.to raise_error(ArgumentError) }

        it { expect(subject.product_property_and_property_version_ids(product_id: 1).class).to eq(Array) }

        it { expect(subject.product_property_and_property_version_ids(product_id: 1)).to be_empty }

        it { expect(subject.product_property_and_property_version_ids(product_id: 1)).to_not be_nil }
      end
    end
  end
end
