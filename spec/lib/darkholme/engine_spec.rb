require 'spec_helper'

module Darkholme
  describe Engine do
    subject { Engine.new }
    let(:entity) { Entity.new }

    it "can add an entity" do
      expect {
        subject.add_entity(entity)
      }.to change { subject.entities.count }.from(0).to(1) 
    end
  end
end

