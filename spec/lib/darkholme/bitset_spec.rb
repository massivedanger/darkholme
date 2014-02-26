require 'spec_helper'

module Darkholme
  describe Bitset do
    subject { Bitset.new }
    let(:bit) { 3 }

    it "can set bits" do
      subject.set(bit)
      expect(subject.set?(bit)).to eq(true)
    end

    it "can set bits to false" do
      subject.set(bit)
      expect(subject.set?(bit)).to eq(true)

      subject.set(bit, false)
      expect(subject.set?(bit)).to eq(false)
    end

    it "has a list of set indexes" do
      subject.set(3)
      subject.set(4)
      subject.set(5)

      expect(subject.set_indexes).to match_array([3, 4, 5])
    end

    it "can clear bits" do
      subject.set(bit)
      expect(subject.set?(bit)).to eq(true)

      expect {
        subject.clear(bit)
      }.to change { subject.bits }

      expect(subject.set?(bit)).to eq(false)
    end

    it "removes the set index during a clear" do
      subject.set(bit)
      expect(subject.set_indexes).to include(bit)
      subject.clear(bit)

      expect(subject.set_indexes).to be_empty
    end

    it "can check for bit set status via array operators" do
      subject.set(bit)

      expect(subject[bit]).to eq(true)
    end

    it "can set bits via array operator" do
      subject[bit] = true

      expect(subject.set?(bit)).to eq(true)
    end

    it "can be compared to other bitsets" do
      other = Bitset.new(bit)
      subject.set(bit)

      expect(subject).to eq(other)
    end

    it "can check for complete inclusion of other bitsets" do
      subject.set(3)
      subject.set(4)
      subject.set(5)

      other = Bitset.new
      other.set(4)
      other.set(5)

      expect(subject.include? other).to eq(true)
    end

    it "can check for inclusion even if the orders are different" do
      subject.set(10)
      subject.set(7)
      subject.set(4)

      other = Bitset.new
      other.set(4)
      other.set(10)

      expect(subject.include? other).to eq(true)
    end
  end
end
