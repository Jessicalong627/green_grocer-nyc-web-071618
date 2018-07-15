def consolidate_cart(cart:[])
  # code here

  final = {}
  temp = []
    cart.each do |x|
        x.each do |k, v|
            temp << k
            if final.has_key?(k)
                final[k][:count] = temp.count(k)
            else
                v[:count] = 1
                final[k] = v
            end
        end
    end
    final
end

def apply_coupons(cart, coupons)
  # code here
  final = cart.clone
  temp = ""
  cart.each do |k,v|
      coupons.each do |c|
           if c[:item] == k && v[:count] >= c[:num]
            temp = "#{k} W/COUPON"
            number = (v[:count]/c[:num])
            final[k][:count] = (v[:count]%c[:num])
            final[temp] = {:price => c[:cost], :clearance => v[:clearance], :count => number}
                # if final[k][:count] == 0
                #     final.delete(k)
                # end
           end
      end
  end
 final
end

def apply_clearance(cart)
  # code here
  final = {}
    cart.each do |k,v|
      final[k]= v
      if v[:clearance] == true
        final[k][:price] = (final[k][:price] * 0.8).round(2)
      end
    end
  final
end

def checkout(cart, coupons)
  # code here
  consolidate = consolidate_cart(cart: cart)
  couponed = apply_coupons(cart:consolidate, coupons: coupons)
  final = apply_clearance(cart:couponed)
  cost = 0.00

  final.each do |k,v|
      cost += (v[:price]*v[:count]).round(2)
  end
  if cost >= 100.00
    cost = cost *0.9
  end
  cost
end