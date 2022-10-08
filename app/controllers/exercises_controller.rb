class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    @foods = Food.left_outer_joins(:orders).where(orders: {id: nil})
    
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    @shops = Shop.left_outer_joins(foods: :orders).where(orders: {id: nil}).group(:id)
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    addresses = Address.joins(:orders)
                       .group(:id)
                       .select("addresses.*, addresses.count AS orders_count")
                       .order(orders_count: :desc)

    @address = addresses.first
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    customers = Customer.joins(orders: :foods)
                        .group(:id)
                        .select("customers.*, SUM(foods.price) AS foods_price_sum")
                        .order(foods_price_sum: :desc)

    @customer = customers.first
  end
end
