require 'spec_helper'

module Darkholme
  describe Bitset do
    subject { Bitset.new }

    it "can add bits" do
      subject.add(3)
      expect(subject.contains?(3)).to eq(true)
    end
  end
end
