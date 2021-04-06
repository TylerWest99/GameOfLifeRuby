#
#  Game of Life class
#
#  Author(s): Tyler West
#
class GameOfLife

    # Creates getter methods for instance variables @rows and @cols
    attr_reader  :rows, :cols

    # Constructor that initializes instance variables with default values
    def initialize()
        @grid = []
        @rows = 0
        @cols = 0
    end

    # Reads data from the file, instantiates the grid, and loads the
    # grid with data from file. Sets @grid, @rows, and
    # @cols instance variables for later use.
    def loadGrid(file)
        data = IO.read(file)
        tokens = data.strip.split(' ')

        @rows = tokens.shift.to_i
        @cols = tokens.shift.to_i

        #
        # Done
        for i in 0..@rows-1
            @grid[i] = Array.new
            for j in 0..@cols-1
                @grid[i][j] = tokens.shift.to_i
            end
        end
    end

    # Saves the current grid values to the file specified
    def saveGrid(file)
        data = @rows.to_s + ' ' + @cols.to_s

        #
        # Done
        for i in 0..@rows-1
            for j in 0..@cols-1
                dataValue = @grid[i][j]
                dataString = dataValue.to_s
                data = data + " " + dataString
            end
        end

        data += "\n"
        IO.write(file, data)
    end

    # Mutates the grid to next generation
    def mutate()
        # make a copy of grid and fill it with zeros
        temp = Array.new(@rows)
        for i in (0...@rows)
            temp[i] = Array.new(@cols)
            temp[i].fill(0)
        end

        #
        # TO DO: set values in temp grid to next generation

        # sets old grid
        for i in 0..@rows-1
            for j in 0..@cols-1
                temp[i][j] = @grid[i][j]
            end 
        end

        # changes the values in temp

        # sets neighbors to 0
        numNeighbors = 0

        for i in 0..@rows-1
            for j in 0..@cols-1

                # sets num of neighbors
                numNeighbors = getNeighbors(i,j);
    
                if @grid[i][j] == 1 && numNeighbors < 2
                    temp[i][j] = 0
                end

                if @grid[i][j] == 1 && numNeighbors > 3
                    temp[i][j] = 0
                end

                if @grid[i][j] == 0 && numNeighbors == 3
                    temp[i][j] = 1
                end

                if @grid[i][j] == 1 && (numNeighbors == 2 || numNeighbors == 3)
                    temp[i][j] = 1
                end
            end
        end



        # DO NOT DELETE: set @grid to temp grid
        @grid = temp
    end

    # Returns the number of neighbors for cell at @grid[i][j]
    def getNeighbors(i, j)
        neighbors = 0

        #
        # Done
        
        for ii in -1..1
		    for jj in -1..1

			    # does nothing for itself
			    if ii == 0 && jj == 0
				    next
                end

			    currentRow = i + ii
			    currentCol = j + jj

			    if currentRow < 0 || currentRow >= @rows
				    next
                end

			    if currentCol < 0 || currentCol >= @cols
				    next
                end

			    if @grid[currentRow][currentCol] == 1
				    neighbors = neighbors + 1
                end

		    end
	    end

        # DO NOT DELETE THE LINE BELOW
        neighbors
    end

    # Returns a string representation of GameOfLife object
    def to_s
        str = "\n"
        for i in 0...@rows
            for j in 0...@cols
                if @grid[i][j] == 0
                    str += ' . '
                else
                    str += ' X '
                end
            end
            str += "\n"
        end
        str
    end

end
