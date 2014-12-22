require 'spec_helper'

RSpec.describe Spree::OrderVersion, :type => :model do
  context "OrderVersionVariantHelpers" do
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
    describe ":variant_versions" do
      it { expect(described_class).to respond_to :variant_versions }

      it { expect{described_class.variant_versions}.to raise_error(ArgumentError) }
    end

    describe ":variants_version_ids" do
      it { expect(subject).to respond_to :variants_version_ids }

      it { expect{subject.variants_version_ids}.to raise_error(ArgumentError) }

      it { expect(subject.variants_version_ids(product_id: 1).class).to eq(Array) }

      it { expect(subject.variants_version_ids(product_id: 1)).to be_empty }

      it { expect(subject.variants_version_ids(product_id: 1)).to_not be_nil }
    end

    describe ":variants" do
      it { expect(subject).to respond_to :variants }

      it { expect{subject.variants}.to raise_error(ArgumentError) }

      it { expect(subject.variants(product_id: 1).class).to eq(Array) }

      it { expect(subject.variants(product_id: 1)).to be_empty }

      it { expect(subject.variants(product_id: 1)).to_not be_nil }
    end

    describe ":variant_version_id" do
      subject { FactoryGirl.build(:order_version) }

      it { expect(subject).to respond_to :variant_version_id }

      it { expect{subject.variant_version_id}.to raise_error(ArgumentError) }

      it { expect(subject.variant_version_id(variant_id: 1).class).to eq(Fixnum) }

      it { expect(subject.variant_version_id(variant_id: 1)).to_not be_nil }

      context "with invalid :variant_id" do
        it { expect(subject.variant_version_id(variant_id: 2)).to be_nil }
      end
    end

    describe ":variant" do
      let(:variant) { FactoryGirl.create(:variant) }

      it { expect(subject).to respond_to :variant }

      it { expect{subject.variant}.to raise_error(ArgumentError) }

      it 'should eq Hash' do
        version = variant.current_version
        status  = {
                    variants: [{product_id: variant.product_id, variant_id: variant.id, version_id: version.id}]
                  }
        order_version = FactoryGirl.build(:order_version, status: status)

        expect(order_version.variant(variant_id: variant.id).class).to eq(Spree::Variant)
        expect(order_version.variant(variant_id: variant.id)).to eq(version.reify)
        expect(order_version.variant(variant_id: variant.id)).to eq(variant)
      end
    end
  end
end
