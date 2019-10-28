# frozen_string_literal: true

require 'rails_helper'

describe StockMovements::Create do
  subject(:stock_movement) do
    described_class.call(stock_unit, stock_movement_params)
  end

  let(:stock_unit) { create(:stock_unit) }
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:stock_movement_params) do
    {
      selling: create(:selling, user: user, product: product),
      amount: 1,
      cost: 11.11,
      measure_units: 'kg',
      brake: true
    }
  end

  shared_examples 'stock movement invalid' do
    it 'returns StockMovement#count' do
      expect { subject }.not_to change { StockMovement.count }.from(0)
    end
  end

  context 'without stock unit' do
    let(:stock_unit) {}

    it_behaves_like 'stock movement invalid', ['please specify user', 'User must exist']
  end

  context 'correct' do
    it 'returns StockMovement#count' do
      expect { subject }.to change { StockMovement.count }.from(0).to(1)
    end
  end
end
