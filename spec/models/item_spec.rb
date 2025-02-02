# frozen_string_literal: true

require_relative '../../app/services/tax_calculator'
require_relative '../../app/models/item'

describe Item do
  subject(:item) { described_class.new(product_name, price_in_cents) }

  let(:product_name) { Faker::Commerce.product_name }
  let(:price_in_cents) { Faker::Number.number(digits: 4) }

  describe '#tax' do
    let(:tax_calculator) { instance_double(TaxCalculator) }

    it 'calls Tax calculator service with given item' do
      allow(TaxCalculator).to receive(:new).with(item).and_return(tax_calculator)
      allow(tax_calculator).to receive(:call)

      item.tax

      expect(tax_calculator).to have_received(:call)
    end
  end

  describe '#category' do
    described_class::CATEGORY_KEYWORDS.each do |category, keywords|
      keywords.each do |keyword|
        context "when product name contains #{keyword}" do
          let(:product_name) { "This is a #{keyword} product" }

          it "returns #{category} for product names containing #{keyword}" do
            expect(item.category).to eq(category)
          end
        end
      end
    end
  end

  describe '#imported?' do
    context 'when product name does not contain "imported"' do
      let(:product_name) { 'product' }

      it 'returns false for product names not containing "imported"' do
        expect(item.imported?).to be(false)
      end
    end

    context 'when product name contains "imported"' do
      let(:product_name) { 'imported product' }

      it 'returns true for product names containing "imported"' do
        expect(item.imported?).to be(true)
      end
    end
  end
end
