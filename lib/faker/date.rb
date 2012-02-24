module Faker
  module Date
    def sometime_last_year(date = ::Date.today)
      date - rand(365)
    end

    def sometime_next_fortnight(date = ::Date.today)
      date + rand(14) + 1
    end

    def sometime_next_week(date = ::Date.today)
      date + rand(7) + 1
    end
  end
end
