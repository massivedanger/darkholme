class MockEntity < Darkholme::Entity
end

class MockComponent < Darkholme::Component
end

class MockSystem < Darkholme::System
  has_family MockComponent
end

class MockIteratingSystem < Darkholme::IteratingSystem
  has_family MockComponent
end
