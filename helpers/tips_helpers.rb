def total_tips(tips)
    total = 0
    tips.each do |tip|
      total += tip["tip_amount"].to_f
    end
    total
end