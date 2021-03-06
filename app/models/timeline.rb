class Timeline
  def initialize(project, opts={})
    @project = project
    @opts = opts
  end

  def matrix
    @project.timetracks.any? ? build_matrix : []
  end

  private

    # TODO: fix it. Ruby code that needs explanation sucks.
    # rethink all the timeline logic.
    # Do we really need this complex matrix? Why not just display all the timetracks for the current period?

    # First row of the matrix consists only from dates where first element is always empty string.
    # Other rows corresponds to the members of a project, that tracked some time on it.
    # First element of user's row is their email.
    # Other elements contains total amount of tracked time at corresponding day on this project.
    # Matrix looks like: [ ['', day1, day2, day3, ...], [email, '', amount, ''], ... ]
    def build_matrix
      interval = build_interval
      @project.timetracks.where(start_date: interval)
    end
    def build_matrix2
      interval = build_interval
      matrix = []
      matrix << @project.timetracks.where(start_date: interval).pluck(:start_date).uniq.unshift('')
      members = []
      members << @project.members.includes(:timetracks)
      members << @project.owner

      members.flatten!.each do |member|
        if member.timetracks.any?
          row = [''] * matrix[0].length
          row[0] = member.email

          member.timetracks.each do |track|
            date = track.start_date
            i = matrix[0].index(date)

            increase_tracked_amount(track.amount, row, i) unless i.nil?
          end
          matrix << row
        end
      end
      matrix
    end

    def build_interval
      last_week = (Time.now - 7.days)..Time.now

      if @opts.any?
        to   = @opts[:to]
        from = @opts[:from]

        if from
          to ? from..to : from..Time.now
        else
          last_week
        end
      else
        last_week
      end
    end

    def increase_tracked_amount(amount, row, i)
      if row[i].is_a? Integer
        row[i] += amount
      else
        row[i] = amount
      end
    end
end
