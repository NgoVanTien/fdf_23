module Admin::StatisticsHelper
  def produc_by_is_order
    column_chart @items.group(:product_id ).where(is_order: 1).count, height: '500px', library: {
      title: {text: 'Sporters by age', x: -20},
      yAxis: {
         allowDecimals: false, # Chỉ hiển thị số nguyên trên trục y
         title: {
             text: 'Order count'
         }
      },
      xAxis: {
         title: {
             text: 'Product'
         }
      }
    }
  end
end
