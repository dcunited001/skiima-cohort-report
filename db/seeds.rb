User.delete_all
Order.delete_all

start_date = (Time.now - 3.months).utc
end_date = Time.now.utc
interval = 1.days

class User
  attr_accessor :order_rate
end

@user_type_rate = {
  top: 1,
  heavy: 2,
  normal: 4,
  light: 2,
  non: 1
}

@user_order_rate = {
  top: 0.6,
  heavy: 0.3,
  normal: 0.05,
  light: 0.01,
  non: 0
}

@users = {
  top: [],
  heavy: [],
  normal: [],
  light: [],
  non: []
}

def new_users(this_date)
  @user_type_rate.reduce({}) do |memo, (k, v)|
    memo[k] = (0..v).map do |i|
      hours_offset = (rand(12).to_i + 6)
      User.create!(created_at: (this_date + hours_offset.hours), updated_at: Time.now.utc, order_rate: @user_order_rate[k])
    end
    memo
  end
end

def add_users(users, this_date)
  new_users(this_date).reduce(users) do |memo, (k, v)|
    memo[k] = memo[k] + v
    memo
  end
end

def add_orders(users, this_date)
  users.each do |k, v|
    hours_offset = rand(12).to_i + 6
    v.each do |user|
      if user.order_rate > rand
        user.orders.create!(created_at: this_date + hours_offset.hours, updated_at: Time.now.utc)
      end
    end
  end
end


def datetime_range_with_inteval(from, to, interval)
  (from.to_i .. to.to_i).step(interval).map do |t|
    Time.at(t).utc.to_datetime
  end
end

def generate_seeds(from, to, interval)
  datetime_range_with_inteval(from, to, interval).each do |this_date|
    @users = add_users(@users, this_date)
    add_orders(@users, this_date)
  end
end

generate_seeds(start_date, end_date, interval)

DB_SEED_FINISHED = true unless defined? DB_SEED_FINISHED