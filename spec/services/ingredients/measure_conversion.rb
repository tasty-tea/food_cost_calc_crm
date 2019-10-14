require 'rails_helper'

RSpec.describe Ingredients::MeasureConversion do
  subject do 
    described_class.call(stock_unit_id: stock_unit&.id,
                         amount: amount,
                         measure_units: measure_units)
  end

  let(:stock_unit) { create(:stock_unit) }
  let(:amount) { 1000 }
  let(:measure_units) { 'kg' }

  shared_examples 'argument is incorrect' do
    it 'returns Result with false success parameter' do
      expect(subject.success?).to eq false
    end
  end

  context 'without stock unit' do
    let(:stock_unit) {}
    it_behaves_like 'argument is incorrect', ['stock unit is missing']
  end

  context 'without amount' do
    let(:amount) {}
    it_behaves_like 'argument is incorrect', ['amount is missing']
  end

  context 'without measure_units' do
    let(:measure_units) {}
    it_behaves_like 'argument is incorrect', ['stock unit is missing']
  end

  context 'with measure_units' do
    context 'when measure_units unknown' do
      let(:stock_unit) { create(:stock_unit, measure_units: "qqpt") }
      let(:measure_units) { 'pstg' }
      it_behaves_like 'argument is incorrect', ['incorrect measure unit selected']
    end

    context 'when measure_units correct' do
      context 'convert kg to g' do
        let(:stock_unit) { create(:stock_unit, measure_units: "g") }
        let(:measure_units) { 'kg' }
        it 'returns Result with success and kg is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'g'
          expect(subject.object.amount).to eq 1000000
        end
      end

      context 'convert g to kg' do
        let(:stock_unit) { create(:stock_unit, measure_units: "kg") }
        let(:measure_units) { 'g' }
        it 'returns Result with success and g is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'kg'
          expect(subject.object.amount).to eq 1
        end
      end

      context 'convert ml to l' do
        let(:stock_unit) { create(:stock_unit, measure_units: "l") }
        let(:measure_units) { 'ml' }
        it 'returns Result with success and ml is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'l'
          expect(subject.object.amount).to eq 1
        end
      end

      context 'convert l to ml' do
        let(:stock_unit) { create(:stock_unit, measure_units: "ml") }
        let(:measure_units) { 'l' }
        it 'returns Result with success and l is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'ml'
          expect(subject.object.amount).to eq 1000000
        end
      end

      context 'not convert pieses to anything' do
        let(:stock_unit) { create(:stock_unit, measure_units: "pieces") }
        let(:measure_units) { 'pieces' }
        it 'returns Result with success and pieces is not converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'pieces'
          expect(subject.object.amount).to eq 1000
        end
      end
    end
  end
end 