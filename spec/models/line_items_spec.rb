# frozen_string_literal: true

require_relative '../../app/models/line_item'

describe LineItem do
  subject(:line_item) { described_class.new(item, Faker::Number.positive) }

  let(:item) { instance_double(Item) }

  before do
    allow(item).to receive_messages(tax: Faker::Number.positive, price_in_cents: Faker::Number.positive)
  end

  describe '#tax' do
    it 'calls item tax' do
      line_item.tax
      expect(item).to have_received(:tax)
    end

    it 'returns item tax * quantity' do
      expect(line_item.tax).to eq(item.tax * line_item.quantity)
    end
  end

  describe '#total' do
    it 'calls item tax' do
      line_item.total
      expect(item).to have_received(:tax)
    end

    it 'calls item price_in_cents' do
      line_item.total
      expect(item).to have_received(:price_in_cents)
    end

    it 'returns item price * quantity + tax' do
      expect(line_item.total).to eq((line_item.quantity * item.price_in_cents) + line_item.tax)
    end
  end
end
