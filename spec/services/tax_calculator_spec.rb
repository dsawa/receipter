# frozen_string_literal: true

require_relative '../../app/services/tax_calculator'
require_relative '../../app/models/item'

describe TaxCalculator do
  subject(:tax_calculation) { described_class.new(item).call }

  let(:item_price_in_cents) { 1000 }
  let(:item_product_name) { 'regular product' }

  let(:item) { Item.new(item_product_name, item_price_in_cents) }

  describe '#call' do
    context 'when regular non-imported item' do
      it 'returns only base tax' do
        expected_tax = item_price_in_cents * described_class::BASE_TAX_RATE
        expect(tax_calculation).to eq(expected_tax)
      end
    end

    context 'when imported item' do
      let(:item_product_name) { 'imported product' }

      it 'returns base + import duty tax' do
        base_tax_value = item_price_in_cents * described_class::BASE_TAX_RATE
        import_duty_value = item_price_in_cents * described_class::IMPORT_DUTY_RATE

        expected_tax_value = base_tax_value + import_duty_value

        expect(tax_calculation).to eq(expected_tax_value)
      end
    end

    context 'when tax exempt non-imported item' do
      let(:item_product_name) { 'book ' }

      it 'returns zero tax' do
        expect(tax_calculation).to eq(0)
      end
    end

    context 'when tax exempt imported item' do
      let(:item_product_name) { 'imported book' }

      it 'returns only import duty' do
        expected_tax = item_price_in_cents * described_class::IMPORT_DUTY_RATE
        expect(tax_calculation).to eq(expected_tax)
      end
    end

    context 'when price needs to be rounded to nearest round rate' do
      let(:item_price_in_cents) { 499 }

      it 'rounds up to nearest 5 cents' do
        expect(tax_calculation).to eq(50)
      end
    end

    context 'when rounding base tax and import duty' do
      let(:item_product_name) { 'imported product' }
      let(:item_price_in_cents) { 1122 }

      it 'rounds combined taxes up to nearest 5 cents' do
        # (base tax + import duty) = 112.2 + 56.1 = 168.3 ~ 170
        expect(tax_calculation).to eq(170)
      end
    end
  end
end
