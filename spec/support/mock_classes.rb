class MockEntity < Darkholme::Entity
end

class MockComponent < Darkholme::Component
end

class MockSystem < Darkholme::System
  has_family MockComponent
end
