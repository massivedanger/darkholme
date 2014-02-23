require 'spec_helper'

module Darkholme
  describe IteratingSystem do
    subject { MockIteratingSystem.new }

    it "loops through entities on update" do
      expect(subject).to receive(:entities).and_return([:one, :two, :three])
      expect(subject).to receive(:process).exactly(3).times.and_return(true)

      subject.update(:delta)
    end

    it "calls before_processing before processing" do
      expect(subject).to receive(:before_processing)
      expect(subject).to receive(:entities).and_return([])

      subject.update(:delta)
    end

    it "calls after_processing after processing" do
      expect(subject).to receive(:after_processing)
      expect(subject).to receive(:entities).and_return([])

      subject.update(:delta)
    end
  end
end
