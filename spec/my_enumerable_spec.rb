# frozen_string_literal: true

require 'rspec'
require_relative '../my_enumerable'

RSpec.describe MyEnumerable do
  let(:arr) { [0, 12, -587] }
  let(:arr_w) { %w[rude tail options] }

  describe '#my_reject' do
    context 'when block exist' do
      it { expect(arr.my_reject) == arr.to_enum(:my_reject) }
    end

    context 'when block given' do
      it { expect(arr.my_reject { |n| n >= 5 }).to eq([0, -587]) }
    end
    # context 'when block with no valid content' do
    #   it { expect { arr.my_reject { |_| raise NoMethodError } }.to raise_error(NoMethodError) }
    # end
  end

  describe '#my_all?' do
    context 'when block exist' do
      it { expect(arr.my_all?).to eq(true) }
    end

    context 'when has params' do
      it { expect(arr.my_all?(Numeric)).to eq(true) }
    end

    context 'with nil' do
      it { expect([1, 3, 54, -56, nil, 'asd'].my_all?).to eq(false) }
    end
  end
end
