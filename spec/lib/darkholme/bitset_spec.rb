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

    it "can clear bits" do
      subject.set(bit)
      expect(subject.set?(bit)).to eq(true)
      
      expect {
        subject.clear(bit)
      }.to change { subject.bits }

      expect(subject.set?(bit)).to eq(false) 
    end

    it "can flip bits" do
      subject.flip(bit)
      expect(subject.set?(bit)).to eq(true)

      subject.flip(bit)
      expect(subject.set?(bit)).to eq(false)
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
  end
end
