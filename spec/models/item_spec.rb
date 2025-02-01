# frozen_string_literal: true

require_relative '../../app/models/item'

describe Item do
  subject(:item) { described_class.new(product_name, price_in_cents) }

  let(:product_name) { Faker::Commerce.product_name }
  let(:price_in_cents) { Faker::Number.number(digits: 4) }

  describe '#tax' do
    it 'raises an error' do
      expect { item.tax }.to raise_error(NotImplementedError, 'Implement Tax calculation logic')
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
