require 'rails_helper'

RSpec.describe Ingredients::MeasureConversion do
  subject do 
    described_class.call(source_measure_units: source_measure_units,
                         target_measure_units: target_measure_units,
                         amount: amount
                         )
  end

  let(:source_measure_units) { 'kg' }
  let(:target_measure_units) { 'g' }
  let(:amount) { 1000 }
  
  shared_examples 'argument is incorrect' do
    it 'returns Result with false success parameter' do
      expect(subject.success?).to eq false
    end
  end

  context 'without target' do
    let(:target_measure_units) {}
    it_behaves_like 'argument is incorrect', ['stock unit is missing']
  end

  context 'without amount' do
    let(:amount) {}
    it_behaves_like 'argument is incorrect', ['amount is missing']
  end

  context 'without source' do
    let(:source_measure_units) {}
    it_behaves_like 'argument is incorrect', ['stock unit is missing']
  end

  context 'with measure_units' do
    context 'when measure_units unknown' do
      let(:source_measure_units) { 'pstg' }
      let(:target_measure_units) { 'qqpt' }
      it_behaves_like 'argument is incorrect', ['incorrect measure unit selected']
    end

    context 'when measure_units correct' do
      context 'convert kg to g' do
        let(:source_measure_units) { "g" }
        let(:target_measure_units) { 'kg' }
        it 'returns Result with success and kg is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'g'
          expect(subject.object.amount).to eq 1000000
        end
      end

      context 'convert g to kg' do
        let(:source_measure_units) { 'kg'}
        let(:target_measure_units) { 'g' }
        it 'returns Result with success and g is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'kg'
          expect(subject.object.amount).to eq 1
        end
      end

      context 'convert ml to l' do
        let(:source_measure_units) { "l" }
        let(:target_measure_units) { 'ml' }
        it 'returns Result with success and ml is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'l'
          expect(subject.object.amount).to eq 1
        end
      end

      context 'convert l to ml' do
        let(:source_measure_units) { "ml" }
        let(:target_measure_units) { 'l' }
        it 'returns Result with success and l is converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'ml'
          expect(subject.object.amount).to eq 1000000
        end
      end

      context 'not convert pieses to anything' do
        let(:source_measure_units) { 'pieces' }
        let(:target_measure_units) { 'pieces' }
        it 'returns Result with success and pieces is not converted' do
          expect(subject.success?).to eq true
          expect(subject.object.measure_units).to eq 'pieces'
          expect(subject.object.amount).to eq 1000
        end
      end
    end
  end
end 