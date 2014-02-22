require 'spec_helper'

module Darkholme
  describe Family do
    subject { Family.for(MockComponent) }

    describe ".for" do
      it "creates a new family" do
        expect(subject).to be_a Family
      end

      it "returns the same family if it exists" do
        second_family = Family.for(MockComponent)
        expect(second_family).to eq(subject)
      end
    end

    describe "#member?" do
      let(:entity) { MockEntity.new }
      it "returns true if the component bits match" do
        entity.add_component(MockComponent.new)
        expect(subject.member?(entity)).to eq(true)
      end

      it "returns false if the bits don't match" do
        expect(subject.member?(entity)).to eq(false)
      end
    end
  end
end
