require 'spec_helper'

fixtures = [
  [[1,2,[3,[5]]],4],
  [[1,2,[3,[5]]],4,[[1,2,[3,[5]]],18]],
  [[1,2,[3,5,6,7,8]],4,[[1,2,[3,[5]]],[1],8]],
  [],
  ['a',1,[[nil]]]
]

describe Array do
  describe '.my_flatten' do
    fixtures.each do |fixture|
      it 'returns a flatten Array' do
        expect(fixture.my_flatten).to eq(fixture.flatten)
      end
    end
  end
end
