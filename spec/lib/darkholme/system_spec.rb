require 'spec_helper'

module Darkholme
  describe System do
    subject { MockSystem.new }

    describe ".has_family" do
      it "sets the class-wide family" do
        expect { 
          EmptySystem.has_family MockComponent
        }.to change { EmptySystem.family }
          .from(nil).to(an_instance_of Family)
      end
    end

    it "raises on update" do
      expect { subject.update(:delta) }.to raise_error NotImplementedError
    end

    describe "with callbacks" do
      it "sets engine when added" do
        subject.added_to_engine(:engine)
        expect(subject.engine).to eq(:engine)
      end

      it "clears engine when removed if they match" do
        subject.engine = :engine
        subject.removed_from_engine(:engine)
        expect(subject.engine).to be_nil
      end

      it "leaves engine alone when removed if they don't match" do
        subject.engine = :no
        subject.removed_from_engine(:engine)
        expect(subject.engine).to eq(:no)
      end
    end

    it "has entities" do
      subject.engine = Engine.new
      expect(subject.engine).to receive(:entities_for_family)
        .with(subject.family)
        .and_return([])

      expect(subject.entities).to eq([])
    end

    it "has a family" do
      expect(subject.family).to eq(subject.class.family)
    end

    private

    class EmptySystem < System; end
  end
end
