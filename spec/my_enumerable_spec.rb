# frozen_string_literal: true

require 'rspec'
require_relative '../my_enumerable'

RSpec.describe MyEnumerable do
  let(:array) { [0, 12, -587] }
  let(:array_words) { %w[rude tail options] }

  describe '#my_reject' do
    context 'when block exist' do
      it { expect(array.my_reject) == array.to_enum(:my_reject) }
    end

    context 'when block given' do
      it { expect(array.my_reject { |n| n >= 5 }).to eq([0, -587]) }
    end
    # context 'when block with no valid content' do
    #   it { expect { arr.my_reject { |_| raise NoMethodError } }.to raise_error(NoMethodError) }
    # end
  end

  describe '#my_all?' do
    context 'when block exist' do
      it { expect(array.my_all?).to eq(true) }
    end

    context 'when has params' do
      it { expect(array.my_all?(Numeric)).to eq(true) }
    end

    context 'with nil or false' do
      it { expect([1, 3, 54, -56, nil, 'asd'].my_all?).to eq(false) }
      it { expect([1, 3, 54, false, -56, 'asd'].my_all?).to eq(false) }
    end

    context 'when block given' do
      it { expect([12, 45, 53, 0].my_all? { |n| n >= 0 }).to eq(true) }
    end
  end

  describe '#my_include?' do
    context 'with params' do
      it { expect([1, 25, 'ruby', nil, 894].my_include?(894)).to eq(true) }
    end
  end

  describe '#my_any?' do
    context 'when empty array' do
      it { expect([].my_any?).to eq(false) }
    end

    context 'without params and block' do
      it { expect(array.my_any?).to eq(true) }
    end

    context 'with params' do
      it { expect([1, 25, nil].my_any?(nil)).to eq(true) }
    end

    context 'with block' do
      it { expect(array.my_any? { |n| n >= 12 }).to eq(true) }
    end
  end

  describe '#my_none?' do
    context 'with block' do
      it { expect(array_words.my_none? { |word| word.length == 5 }).to eq(true) }
    end

    context 'without block' do
      it { expect([nil, false].my_none?).to eq(true) }
    end

    context 'with params' do
      it { expect(array.my_none?(Float)).to eq(true) }
    end
  end

  describe '#each' do
    context 'without block' do
      it { expect(array.my_each) == array.to_enum(:my_each) }
    end

    context 'with block' do
      it { expect([1, 2].my_each { |x| print x, ' -- ' }) == ('1 -- 2 -- '[1, 2]) }
    end
  end

  describe '#map!' do
    context 'with block' do
      it { expect([0, 12, -5].my_map! { |n| n * n }).to eq([0, 144, 25]) }
    end

    context 'without block' do
      it { expect([0, 12, -5].my_map!) == [0, 12, -5].to_enum(:my_map!) }
    end
  end

  describe '#map' do
    context 'with block' do
      it { expect([0, 12, -5].my_map { |n| n * n }) == ([0, 144, 25]) }
    end

    context 'without block' do
      it { expect([0, 12, -5].my_map) == [0, 12, -5].to_enum(:my_map) }
    end
  end

  describe '#size' do
    context 'without everythin' do
      it { expect(array.size).to eq(3) }
    end
  end

  describe '#length' do
    context 'without everythin' do
      it { expect(array.length).to eq(3) }
    end
  end

  describe '#my_count' do
    context 'without params and blocks' do
      it { expect(array.my_count).to eq(3) }
    end

    context 'with params' do
      it { expect(array.my_count(0)).to eq(1) }
    end

    context 'with block' do
      it { expect(array.my_count { |n| n >= 0 }).to eq(2) }
    end
  end

  describe '#my_select' do
    context 'with block' do
      it { expect(array.my_select { |n| n > 5 }).to eq([12]) }
    end

    context 'without block' do
      it { expect(array.my_select) == array.to_enum(:my_select)}
    end
  end

  describe '#find' do
    context 'with block' do
      it { expect(array.my_find { |n| n >= 0 }).to eq(0) }
    end

    context 'without block' do
      it { expect(array.my_find) == array.to_enum(:my_find) }
    end
  end

  describe '#find_all' do
    context 'with block' do
      it { expect(array.my_find_all { |n| n >= 0 }).to eq([0, 12]) }
    end

    context 'without block' do
      it { expect(array.my_find_all) == array.to_enum(:my_find_all) }
    end
  end

  describe '#find_index' do
    context 'with block' do
      it { expect(array.my_find_index { |n| n >= 0 }).to eq(0) }
    end

    context 'without block' do
      it { expect(array.my_find_index) == array.to_enum(:my_find_index) }
    end

    context 'with params' do
      it { expect(array.my_find_index(12)).to eq(1) }
    end
  end

  describe '#my_min' do
    context 'without params' do
      it { expect([-89, 25, -968, 0].my_min).to eq(-968) }
    end

    context 'with params' do
      it { expect([-89, 25, -968, 0].my_min(2)) == ([-986, -89]) }
    end

    context 'when paramenter is 0' do
      it { expect([-89, 25, -968, 0].my_min(0)) == ([]) }
    end
  end

  describe '#my_max' do
    context 'without params' do
      it { expect([-89, 25, -968, 0].my_max).to eq(25) }
    end

    context 'with params' do
      it { expect([-89, 25, -968, 0].my_max(2)) == ([25, 0]) }
    end

    context 'when paramenter is 0' do
      it { expect([-89, 25, -968, 0].my_max(0)) == ([]) }
    end
  end
end
