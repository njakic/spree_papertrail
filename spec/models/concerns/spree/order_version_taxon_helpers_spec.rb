require 'spec_helper'

RSpec.describe Spree::OrderVersion, :type => :model do
  context "OrderVersionTaxonHelpers" do
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
    describe ":taxon_versions" do
      it { expect(described_class).to respond_to :taxon_versions }

      it { expect{described_class.taxon_versions}.to raise_error(ArgumentError) }
    end

    describe ":taxons_version_ids" do
      it { expect(subject).to respond_to :taxons_version_ids }

      it { expect{subject.taxons_version_ids}.to raise_error(ArgumentError) }

      it { expect(subject.taxons_version_ids(product_id: 1).class).to eq(Array) }

      it { expect(subject.taxons_version_ids(product_id: 1)).to be_empty }

      it { expect(subject.taxons_version_ids(product_id: 1)).to_not be_nil }
    end

    describe ":taxons" do
      it { expect(subject).to respond_to :taxons }

      it { expect{subject.taxons}.to raise_error(ArgumentError) }

      it { expect(subject.taxons(product_id: 1).class).to eq(Array) }

      it { expect(subject.taxons(product_id: 1)).to be_empty }

      it { expect(subject.taxons(product_id: 1)).to_not be_nil }
    end

    describe ":taxon_version_id" do
      subject { FactoryGirl.build(:order_version) }

      it { expect(subject).to respond_to :taxon_version_id }

      it { expect{subject.taxon_version_id}.to raise_error(ArgumentError) }

      it { expect(subject.taxon_version_id(taxon_id: 1).class).to eq(Fixnum) }

      it { expect(subject.taxon_version_id(taxon_id: 1)).to_not be_nil }

      context "with invalid :taxon_id" do
        it { expect(subject.taxon_version_id(taxon_id: 2)).to be_nil }
      end
    end

    describe ":taxon" do
      let(:taxon) { FactoryGirl.create(:taxon) }

      it { expect(subject).to respond_to :taxon }

      it { expect{subject.taxon}.to raise_error(ArgumentError) }

      it 'should eq Hash' do
        version = taxon.current_version
        status  = {
                    taxons: [{taxon_id: taxon.id, version_id: version.id}]
                  }
        order_version = FactoryGirl.build(:order_version, status: status)

        expect(order_version.taxon(taxon_id: taxon.id).class).to eq(Spree::Taxon)
        expect(order_version.taxon(taxon_id: taxon.id)).to eq(version.reify)
        expect(order_version.taxon(taxon_id: taxon.id)).to eq(taxon)
      end
    end
  end
end
