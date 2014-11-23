class Timetrack < ActiveRecord::Base
  belongs_to :task
  has_many   :comments

  def parse_amount!(time)
    end_date = start_date = self.start_date
    timings = time.scan(/\d+/).map!(&:to_i)
    
    [:days, :hours, :minutes, :seconds].each_with_index do |method, i|
      val = timings[i].send method
      end_date += val
    end
    
    [end_date, start_date].map! {|date| date.strftime('%s').to_i }
    self.amount = end_date - start_date
  end
end
