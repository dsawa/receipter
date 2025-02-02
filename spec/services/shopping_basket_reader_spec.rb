# frozen_string_literal: true

require_relative '../../app/services/shopping_basket_reader'

describe ShoppingBasketReader do
  subject(:reader) { described_class.new(file_path, Logger.new(nil)).call }

  let(:file_path) { File.join(File.dirname(__FILE__), '../support/fixtures/shopping_basket.txt') }

  describe '#call' do
    context 'when file is fully valid' do
      let(:line_items_count) { File.read(file_path).split("\n").size }

      it 'returns an array of LineItem objects' do
        expect(reader).to all(be_a(LineItem))
      end

      it 'returns the correct number of LineItem objects' do
        expect(reader.size).to eq(line_items_count)
      end

      it 'returns the correct LineItem quantities' do
        expect(reader.map(&:quantity)).to eq([2, 1, 1, 1, 1, 1, 1, 1, 3])
      end

      it 'returns proper Item product names' do
        items = reader.map(&:item)

        expect(items.map(&:product_name)).to eq(['book', 'music CD', 'chocolate bar', 'imported box of chocolates',
                                                 'imported    bottle of perfume', 'imported bottle of perfume',
                                                 'bottle of perfume', 'packet of    headache pills',
                                                 'imported boxes of chocolates'])
      end

      it 'returns proper Item prices' do
        items = reader.map(&:item)
        expect(items.map(&:price_in_cents)).to eq([1249, 1499, 85, 1000, 4750, 2799, 1899, 975, 1125])
      end
    end

    context 'when file has invalid lines' do
      let(:file_path) { File.join(File.dirname(__FILE__), '../support/fixtures/shopping_basket_invalid.txt') }

      it 'raises an error' do
        expect { reader }.to raise_error(RuntimeError, /Shopping Basket format invalid, line:/)
      end
    end
  end
end
