# RefinementsRobbery

Robbing the buried Refinements from ObjectSpace.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refinements_robbery'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install refinements_robbery

## Usage

Require it and rob the refinements.

```rb
require "refinements_robbery"
using *RefinementsRobbery.rob(RefinedClassWhatever)
```

### Example

```rb
class TreasureIsland
  using Module.new {
    refine(TreasureIsland) {
      def safe
        @safe ||= []
      end
    }
  }

  def initialize(treasures)
    treasures.each { |t| safe << t }
    freeze
  end

  def treasure_island?
    !safe.empty?
  end
  freeze
end

island = TreasureIsland.new(["💰", "🏆", "💎"])

if island.treasure_island?
  puts "there are treasures!"
else
  puts "where are the treasures?"
end

# bag = []
# while t = island.safe.shift # undefined method `safe' for #<TreasureIsland:0x00005557b282a1b8> (NoMethodError)
#   bag << t
# end

# class TreasureIsland
#   def safe # can't modify frozen class (FrozenError)
#     @safe
#   end
# end

# def island.safe # can't modify frozen object (FrozenError)
#   @safe
# end

require "refinements_robbery"

using *RefinementsRobbery.rob(TreasureIsland)

bag = []
while t = island.safe.shift
  bag << t
end

if island.treasure_island?
  puts "there are treasures!"
else
  puts "where are the treasures?"
end

puts "treasures are in my bag: #{bag}"
```

Result:

```
% bundle exec ruby foo.rb
there are treasures!
where are the treasures?
treasures are in my bag: ["💰", "🏆", "💎"]
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hanachin/refinements_robbery.
