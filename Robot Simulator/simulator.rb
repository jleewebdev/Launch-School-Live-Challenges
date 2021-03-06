class Robot
  attr_accessor :bearing, :coordinates

  DIRECTIONS = [:north, :east, :south, :west]

  def initialize 
    @coordinates = []
  end

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include? direction
    @bearing = direction
  end

  def turn_right
    @bearing = DIRECTIONS[DIRECTIONS.index(@bearing) + 1] || :north
  end

  def turn_left
    @bearing = DIRECTIONS[DIRECTIONS.index(@bearing) - 1] || :west
  end

  def at(x, y)
    @coordinates[0] = x
    @coordinates[1] = y
  end

  def advance
    case @bearing
    when :north
      @coordinates[1] += 1
    when :east
      @coordinates[0] += 1
    when :south
      @coordinates[1] -= 1
    when :west
      @coordinates[0] -= 1
    end
  end
end

class Simulator
  
  def instructions(directions)
    commands = []
    directions.split("").each do |direction|
      case direction
      when "L"
        commands << :turn_left
      when "R"
        commands << :turn_right
      when "A"
        commands << :advance
      end
    end
      commands
  end

  def place(robot, where)
    robot.at(where[:x], where[:y])
    robot.orient(where[:direction])
  end

  def evaluate(robot, directions)
    instructions(directions).each { |dir| robot.send(dir) }
  end
end




