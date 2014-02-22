# Darkholme

[![Build Status](https://travis-ci.org/massivedanger/darkholme.png?branch=master)](https://travis-ci.org/massivedanger/darkholme)

> Who am I? That, my dear, is an excellent question. Though not one easily answered. 

Darkholme is an [entity-component system](http://en.wikipedia.org/wiki/Entity_component_system) 
written in Ruby. It's still early days for it, but I think it's ready for most basic use cases.

## Usage

_COMING SOON!_

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

