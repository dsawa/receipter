# frozen_string_literal: true

require_relative '../../app/services/receipt_printer'
require_relative '../../app/models/line_item'
require_relative '../../app/models/item'

describe ReceiptPrinter do
  subject(:printed_receipt) { described_class.new(line_items).call }

  let(:regular_item) { Item.new('regular product', 499) }
  let(:imported_item) { Item.new('imported product', 1122) }
  let(:tax_exempt_item) { Item.new('book', 500) }
  let(:line_items) do
    [
      LineItem.new(regular_item, 2),
      LineItem.new(imported_item, 1),
      LineItem.new(tax_exempt_item, 3)
    ]
  end

  describe '#call' do
    let(:expected_output) do
      "2 regular product: 10.98\n" \
        "1 imported product: 12.92\n" \
        "3 book: 15.00\n" \
        "Sales Taxes: 2.70\n" \
        "Total: 38.90\n"
    end

    it 'prints line items and summary' do
      expect { printed_receipt }.to output(expected_output).to_stdout
    end
  end
end
