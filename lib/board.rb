class Board
  attr_reader :cells

  def initialize
    @cells = {
       "A1" => Cell.new("A1"),
       "A2" => Cell.new("A2"),
       "A3" => Cell.new("A3"),
       "A4" => Cell.new("A4"),

       "B1" => Cell.new("B1"),
       "B2" => Cell.new("B2"),
       "B3" => Cell.new("B3"),
       "B4" => Cell.new("B4"),

       "C1" => Cell.new("C1"),
       "C2" => Cell.new("C2"),
       "C3" => Cell.new("C3"),
       "C4" => Cell.new("C4"),

       "D1" => Cell.new("D1"),
       "D2" => Cell.new("D2"),
       "D3" => Cell.new("D3"),
       "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    if @cells[coordinate]
      true
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    valid_length(ship, coordinates) &&
    consecutive_coordinates(coordinates) &&
    overlapping_ships?(ship, coordinates)
  end

  def valid_length(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive_coordinates(coordinates)
    letters = []
    numbers = []

    coordinates.each do |coordinate|
      letters << coordinate[0].ord
      numbers << coordinate[-1].to_i
    end

    if letters.uniq.length == 1
      number_consecutive = numbers.each_cons(2).all? do |a,b|
         a + 1 == b
      end

    elsif numbers.uniq.length == 1
      letter_consecutive = letters.each_cons(2).all? do |a,b|
        a + 1 == b
      end
    else
      false
    end
  end

  def overlapping_ships?(ship, coordinates)
    initial_state = true
    coordinates.each do |coordinate|
      if !@cells[coordinate].empty?
        initial_state = false
      end
    end
    initial_state
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(display_ship = false)
    board_rendering = ["  1 2 3 4"]

    @cells.each_with_index do |cell, index|
      if index % 4 == 0
        board_rendering << " \n#{cell[0][0]}"
      end

      board_rendering << " #{cell[1].render(display_ship)}"
    end

    board_rendering << " \n"
    board_rendering.join

    #another way
    # def render(display = false)
    # "  1 2 3 4 \n"+
    # "A #{@cells["A1"].render(display)} #{@cells["A2"].render(display)} #{@cells["A3"].render(display)} #{@cells["A4"].render(display)}" +
    # "B #{@cells["B1"].render(display)} #{@cells["B2"].render(display)} #{@cells["B3"].render(display)} #{@cells["B4"].render(display)}" +
    # "C #{@cells["C1"].render(display)} #{@cells["C2"].render(display)} #{@cells["C3"].render(display)} #{@cells["C4"].render(display)}" +
    # "D #{@cells["D1"].render(display)} #{@cells["D2"].render(display)} #{@cells["D3"].render(display)} #{@cells["D4"].render(display)}"
  end
end
