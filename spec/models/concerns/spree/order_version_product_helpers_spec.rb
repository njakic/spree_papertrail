require 'spec_helper'

RSpec.describe Spree::OrderVersion, :type => :model do
  context "OrderVersionProductHelpers" do
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
    describe ":product_versions" do
      it { expect(described_class).to respond_to :product_versions }

      it { expect{described_class.product_versions}.to raise_error(ArgumentError) }
    end

    describe ":products_version_ids" do
      it { expect(subject).to respond_to :products_version_ids }

      it { expect(subject.products_version_ids.class).to eq(Array) }

      it { expect(subject.products_version_ids).to be_empty }

      it { expect(subject.products_version_ids).to_not be_nil }
    end

    describe ":products" do
      it { expect(subject).to respond_to :products }

      it { expect(subject.products.class).to eq(Array) }

      it { expect(subject.products).to be_empty }

      it { expect(subject.products).to_not be_nil }
    end

    describe ":product_version_id" do
      subject { FactoryGirl.build(:order_version) }

      it { expect(subject).to respond_to :product_version_id }

      it { expect{subject.product_version_id}.to raise_error(ArgumentError) }

      it { expect(subject.product_version_id(product_id: 1).class).to eq(Fixnum) }

      it { expect(subject.product_version_id(product_id: 1)).to_not be_nil }

      context "with invalid :product_id" do
        it { expect(subject.product_version_id(product_id: 2)).to be_nil }
      end
    end

    describe ":product" do
      let(:product) { FactoryGirl.create(:product) }

      it { expect(subject).to respond_to :product }

      it { expect{subject.product}.to raise_error(ArgumentError) }

      it 'should eq Hash' do
        version = product.current_version
        status  = {
                    products: [{product_id: product.id, version_id: version.id}]
                  }
        order_version = FactoryGirl.build(:order_version, status: status)

        expect(order_version.product(product_id: product.id).class).to eq(Spree::Product)
        expect(order_version.product(product_id: product.id)).to eq(version.reify)
        expect(order_version.product(product_id: product.id)).to eq(product)
      end
    end
  end
end
