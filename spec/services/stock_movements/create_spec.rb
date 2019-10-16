# frozen_string_literal: true

require 'rails_helper'

describe StockMovements::Create do
  subject(:stock_movement) do
    described_class.call(stock_unit.id,
                         amount: message,
                         cost: cost,
                         measure_units: measure_units,
                         brake: brake)
  end

  let(:stock_unit) { create(:stock_unit) }
  let(:amount) { 1 }
  let(:cost) { 11.11 }
  let(:measure_units) { 'kg' }
  let(:brake) { true }

  shared_examples 'stock movement invalid' do
    it 'returns StockMovement#count' do
      expect { subject }.not_to change { StockMovement.count }.from(0)
    end
  end

  context 'without stock unit' do
    let(:stock_unit) {}

    it_behaves_like 'stock movement invalid', ['please specify user', 'User must exist']
  end

  context 'with stock unit' do
    context 'without amount' do
      let(:message) {}

      it_behaves_like 'stock movement invalid', ["Message can't be blank"]
    end

    context 'with amount' do
      it 'returns StockMovement#count' do
        expect(stock_movement).to change { StockMovement.count }.from(0).to(1)
      end

      it 'returns errors' do
        expect(stock_movement.errors.full_messages).to be_empty
      end
    end
  end
end
