# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredients::MeasureConversion do
  subject(:result) do
    described_class.call(source_measure_units: conversion_params[:source],
                         target_measure_units: conversion_params[:target],
                         amount: conversion_params[:amount])
  end

  let(:conversion_params) do
    { source: 'kg',
      target: 'g',
      amount: 1000 }
  end

  shared_examples 'argument is incorrect' do
    it 'returns Result with false success parameter' do
      expect(result.success?).to be false
    end
  end

  shared_examples 'conversion is successful' do |source, target, amount|
    let(:conversion_params) do
      {
        source: source,
        target: target,
        amount: 1000
      }
    end

    it 'returns success' do
      expect(result.success?).to be true
    end

    it "converts #{source} -> #{target}" do
      expect(result.object.measure_units).to eq target
    end

    it "is equal #{amount}" do
      expect(result.object.amount).to eq amount
    end
  end

  context 'without target' do
    let(:conversion_params) do
      {
        source: 'kg',
        target: nil,
        amount: 1000
      }
    end

    it_behaves_like 'argument is incorrect'
  end

  context 'without amount' do
    let(:conversion_params) do
      {
        source: 'kg',
        target: 'g',
        amount: nil
      }
    end

    it_behaves_like 'argument is incorrect'
  end

  context 'without source' do
    let(:conversion_params) do
      {
        source: nil,
        target: 'g',
        amount: 1000
      }
    end

    it_behaves_like 'argument is incorrect'
  end

  context 'when source_measure_units unknown' do
    let(:conversion_params) do
      {
        source: 'pptg',
        target: 'g',
        amount: 1000
      }
    end

    it_behaves_like 'argument is incorrect', ['incorrect source measure unit selected']
  end

  context 'when target_measure_units unknown' do
    let(:conversion_params) do
      {
        source: 'kg',
        target: 'qqpt',
        amount: 1000
      }
    end

    it_behaves_like 'argument is incorrect', ['incorrect target measure unit selected']
  end

  context 'when measure_units correct' do
    context 'with kg to g convertion' do
      it_behaves_like 'conversion is successful', 'kg', 'g', 1_000_000
    end

    context 'with g to kg convertion' do
      it_behaves_like 'conversion is successful', 'g', 'kg', 1
    end

    context 'with ml to l convertion' do
      it_behaves_like 'conversion is successful', 'ml', 'l', 1
    end

    context 'with l to ml convertion' do
      it_behaves_like 'conversion is successful', 'l', 'ml', 1_000_000
    end

    context 'without pieses convertion' do
      it_behaves_like 'conversion is successful', 'pieces', 'pieces', 1000
    end
  end
end
