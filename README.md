# Darkholme

[![Build Status](https://travis-ci.org/massivedanger/darkholme.png?branch=master)](https://travis-ci.org/massivedanger/darkholme)

> Who am I? That, my dear, is an excellent question. Though not one easily answered.

Darkholme is an [entity-component system](http://en.wikipedia.org/wiki/Entity_component_system)
written in Ruby. It's still early days for it, but I think it's ready for most basic use cases.

## Usage

First, you need to create an **Engine** to hold all the other parts of Darkholme.

```ruby
@engine = Darkholme::Engine.new
```

All of your **Systems** and **Entities** will be added to your engine, which will update
them once per frame. Make sure you put an Engine#update inside of your game's update loop, like
so:

```ruby
def update(delta)
  @engine.update(delta)
end
```

Now, you can define an Entity and add **Components** to it, which hold data for your systems
to use. In this case, let's assume you've made a component called `Spatial` that holds an entity's
position along with its velocity. Something like this:

```ruby
class Spatial < Darkholme::Component
  attr_accessor :position, :velocity

  def initialize
    @position = { x: 0, y: 0 }
    @velocity = { x: 0, y: 0 }
  end
end
```

And adding it:

```ruby
new_entity = Darkhole::Entity.new
new_entity.add_component Spatial.new
```

Next is adding your entity to the engine and adding a new system that'll use the Spatial
component and move the entity according to its velocity.

Here's what the system could look like:

```ruby
class PositionSystem < Darkholme::System
  has_family Spatial

  def update(delta)
    entities.each do |entity|
      spatial = entity.component_for Spatial

      spatial.position.x += spatial.velocity.x * delta
      spatial.position.y += spatial.velocity.y * delta
    end
  end
end
```

And adding it and the entity from before:

```ruby
engine.add_system PositionSystem.new
engine.add_entity new_entity
```

Now, as another system modifies the entity's Spatial component velocity, the
PositionSystem will position it according to its velocity, but properly using
the delta between frames for smooth movement.

It's highly encouraged to [read through the documentation](http://rdoc.info/github/massivedanger/darkholme/master/frames)
for the gem, as it can answer most questions you might have about each individual method. Please
[file an issue](https://github.com/massivedanger/darkholme/issues) if you think our documentation is
lacking in some way. Thanks!

## Key concepts

### Engine

Generally, your game will have one Engine. It contains all the entities, systems,
and components. Every frame of your game, you'll need to call `#update` on it. This will,
in turn, update all its relevant systems.

### Entity

This is the basic component-holding class. It also has some callbacks, but it generally just
keeps a list of what it does. These get added to Engines.

### Component

These define data the Systems end up working with. Also, they get added to Entities.

### System

These get called once per frame and they update all the entities with components they're
interested in.

### Family

Systems have a Family, which defines exactly what components they're interested in. This
means that systems won't loop through every single entity on update. They only loop through
relevant entities. This is _awesome_. Maybe.

## Contributing to darkholme

- Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
- Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
- Fork the project.
- Start a feature/bugfix branch.
- Commit and push until you are happy with your contribution.
- Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
- Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Massive Danger. See LICENSE.txt for further details.

