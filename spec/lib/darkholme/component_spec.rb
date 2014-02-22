require 'spec_helper'

module Darkholme
  describe Component do
    subject { MockComponent.new }

    it "returns a unique bit for Components" do
      first_bit = Component.bit_for(MockComponent)
      second_bit = Component.bit_for(Component)

      expect(first_bit).not_to eq(second_bit)
    end

    it "gets a bit from an instance" do
      expect(Component).to receive(:bit_for).with(MockComponent)
                                            .and_return(:bit)
      expect(subject.bit).to eq(:bit)
    end
  end
end
