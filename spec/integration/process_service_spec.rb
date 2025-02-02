# frozen_string_literal: true

require_relative '../../app/services/process_service'

describe ProcessService do
  subject(:process_service_work) do
    described_class.new(['spec/support/fixtures/shopping_basket.txt'], Logger.new(nil)).call
  end

  describe '#call' do
    context 'when valid file it reads, calculates and prints the receipt' do
      let(:expected_output) do
        "2 book: 24.98\n" \
          "1 music CD: 16.49\n" \
          "1 chocolate bar: 0.85\n" \
          "1 imported box of chocolates: 10.50\n" \
          "1 imported    bottle of perfume: 54.65\n" \
          "1 imported bottle of perfume: 32.19\n" \
          "1 bottle of perfume: 20.89\n" \
          "1 packet of    headache pills: 9.75\n" \
          "3 imported boxes of chocolates: 35.55\n" \
          "Sales Taxes: 17.05\n" \
          "Total: 205.85\n\n"
      end

      it 'prints line items and summary' do
        expect { process_service_work }.to output(expected_output).to_stdout
      end
    end
  end
end
