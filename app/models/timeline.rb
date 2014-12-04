class Timeline
  def initialize(project, opts={})
    @project = project
    @opts   = {}
    @opts ||= opts
  end

  def matrix
    @project.timetracks.any? ? build_matrix : []
  end

private

  # [ ['', day1, day2, day3, ...], [email, '', amount, ''], ... ]
  def build_matrix
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
          
          increase_amount(track.amount, row, i) unless i.nil?
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

  def increase_amount(amount, row, i)
    if row[i].is_a? Integer
      row[i] += amount 
    else
      row[i] = amount
    end
  end
end