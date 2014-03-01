require 'spec_helper'

module Darkholme
  describe Engine do
    subject { Engine.new }
    let(:entity) { MockEntity.new }
    let(:system) { MockSystem.new }

    describe "with entities" do
      it "can add them" do
        expect {
          subject.add_entity(entity)
        }.to change { subject.entities.count }.from(0).to(1)
      end

      it "can add them from a manifest" do
        expect {
          subject.add_entity_from_manifest(entity_json)
        }.to change { subject.entities.count }.from(0).to(1)
      end

      it "can remove them" do
        subject.add_entity(entity)

        expect {
          subject.remove_entity(entity)
        }.to change { subject.entities.count }.from(1).to(0)
      end

      it "can find them by family" do
        entity.add_component(MockComponent.new)
        subject.add_entity(entity)
        subject.add_system(system)

        expect(subject.entities_for_family(system.family)).to include(entity)
      end
    end

    describe "with systems" do
      it "can add a system" do
        expect {
          subject.add_system(system)
        }.to change { subject.systems.count }.from(0).to(1)
      end

      it "can remove a system" do
        subject.add_system(system)

        expect {
          subject.remove_system(system.class)
        }.to change { subject.systems.count }.from(1).to(0)
      end

      it "updates them" do
        subject.add_system(system)
        expect(system).to receive(:update).with(:delta)
                                          .and_return(:updated)

        subject.update(:delta)
      end
    end

    describe "with callbacks" do
      let(:family) { Family.for(MockComponent) }
      it "updates families upon component addition" do
        subject.families[family] = []
        entity.engine = subject

        expect(subject.families[family]).not_to include(entity)
        entity.add_component MockComponent.new
        expect(subject.families[family]).to include(entity)
      end

      it "updates families upon component removal" do
        subject.families[family] = [entity]
        entity.engine = subject
        entity.add_component MockComponent.new

        expect(subject.families[family]).to include(entity)
        entity.remove_component MockComponent
        expect(subject.families[family]).not_to include(entity)
      end
    end

    private

    def entity_json
      <<-JSON
{
  "components": {
    "MockComponent": {}
  }
}
      JSON
    end
  end
end

